function odeanimation_fcn(odesol,odepar,fps,testcase)
%ODEANIMATION_FCN Summary of this function goes here
%   Detailed explanation goes here

%% Setup parameters
n_sec = odepar.n_sec;
mv = odepar.mv;
md = odepar.md;
k  = odepar.k;
c  = odepar.c;
l0 = odepar.l0;
fext = odepar.fext;
mf = odepar.mf;
Has1stPC = odepar.Has1stPairConstraints;
LAMBDA_MAX = 33.4934;
K = odepar.K;

%% Save solode data
save(['Data/odesol' testcase],'odesol')

%% IsDisplayOn
IsDisplayOn = false;


%% Initialise the figure for writing video
fig = figure('Name', testcase, 'Position',[100,100,800,600]);
set(fig,'Resize','off')
set(fig,'NumberTitle','off')
pos_vec = get(fig,'Position');
fig_width  = pos_vec(3);
fig_height = pos_vec(4);
% set(fig,'Clipping','off');
						 
if Has1stPC
	ax = axes(fig,'XLIM',[-.1,5.9],'YLIM',[-1,2]);
else
	ax = axes(fig,'XLIM',[-.5,5.5],'YLIM',[-5,1.5]);
end

% set(fig,'CurrentAxes',ax)
% clf(fig)
% set(fig,'Resize','off')
% set(fig,'Position',[100,100,800,600])

% cpink = [255 102 102]/255;
cmuscle = [200 50 50]/255;

n_pair = n_sec + 1;

t0 = odesol.x(1)  ; 
te = odesol.x(end);

ts = 1/fps;
t = t0:ts:te;
n_t = length(t);
t_f = zeros(n_t,1); 

for i = 1:n_t;
	t_ref = t(i);
	tmp = abs(t_ref-odesol.x);
	[~,idx] = min(tmp);
	t_f(i) = idx;
end

vid = VideoWriter(['Videos/' testcase]);
set(vid,'FrameRate',fps)
set(vid,'Quality',100)
open(vid)


%% Create animation frame by frame
for i = 1:length(t_f)
	%% Polygons that form the octopus arm
	j = t_f(i);
	t = odesol.x(j);
	x = odesol.y(:,j);
	
	x_pos = getxpos_fcn(x,n_sec);
	x_vel = getxvel_fcn(x,n_sec);
	
	 q = reshape(x_pos,4,n_pair);
  dq = reshape(x_vel,4,n_pair);
	
	x_ps = [q(1,1:end-1);q(3,1:end-1);q(3,2:end);q(1,2:end)];
	y_ps = [q(2,1:end-1);q(4,1:end-1);q(4,2:end);q(2,2:end)];
	

	%% Specify ftest according to testcase
  [ftest,~] = SelTestCase(testcase,mf,q);
	
	%% Control
	ref.alpha = 90;
	ref.theta = 0;
	ref.a = l0;
	ref.b = l0;
	
	err = calErrors(q,ref);
	[fk,fkc] = CtrlPolicy2(q,err,K);
	
	%% M, G, C, gamma
	M_fcn = str2func(['M_fcn_sec' num2str(n_sec)]);
	G_fcn = str2func(['G_fcn_sec' num2str(n_sec)]);
	C_fcn = str2func(['C_fcn_sec' num2str(n_sec)]);
	gamma_fcn = str2func(['gamma_fcn_sec' num2str(n_sec)]);
	
	M = M_fcn(mv,md);
	G = G_fcn(x_pos);
	C = C_fcn(x_pos);
	gamma = gamma_fcn(x_vel);
	
	% Calculate the forces induced by the springs
	fs_fcn = str2func(['fs_fcn_sec' num2str(n_sec)]);
	fs = fs_fcn(k,l0,x_pos);
	% % fs = fs_fcn_sec1(k,l0,x_pos);
	
	% Calculate the friciton forces
	fd_fcn = str2func(['fd_fcn_sec' num2str(n_sec)]);
	fd = fd_fcn(c,x_vel);
	

	%% lambdas that show the internal pressure of each section
	lambda = (G*(M\C))\(gamma - G*(M\(fext + ftest + fk - fs - fd )));
lambda = (G*(M\C))\(gamma - G*(M\(fk - fs - fd )));

	
	if Has1stPC
		% Constraint forces acting on the 1st pair
		C_nsec = C(:,1:n_sec);
		G_nsec = G(1:n_sec,:);
		gamma_nsec = gamma(1:n_sec);
		lambda_pair1 = lambda(n_sec+1:end);
		
		fc_pair1 = zeros(4*(n_pair),1);
		fc_pair1(1) = lambda_pair1(1);
		fc_pair1(3) = lambda_pair1(2);
		fc_pair1(4) = lambda_pair1(3);
		
		lambda_nsec = (G_nsec*(M\C_nsec))\(gamma_nsec - G_nsec*(M\(fext + ftest + fk - fs - fd - fc_pair1)));
		lambda_nsec = (G_nsec*(M\C_nsec))\(gamma_nsec - G_nsec*(M\(fk - fs - fd - fc_pair1)));
	end
	
	%% Remove visiable objects
	cla(ax)
	
	
% 	%% Draw contracted muscles
% 	lc = .7;
% 	lcr = .5*(1-lc);
% 	wr = 3; % Factor that scales down the line width
% 	
% 	vpos_vi2di   = vpos_vi2di_npair_fcn(q(:,1:end-1));
% 	vpos_vii2dii = vpos_vi2di_npair_fcn(q(:,2:end  ));
% 	vpos_di2dii  = vpos_di2dii_fcn(q);
% 	vpos_vi2vii  = vpos_vi2vii_fcn(q);
% 	vpos_di2vii  = vpos_di2vii_fcn(q);
%   vpos_vi2dii  = vpos_vi2dii_fcn(q);
% 	
% 	% Show the degress of the contractions
% 	for j = 1:n_sec
% 
% 		% fcv(1) = fc_vi2di
% 		% Note that fc_vi2di will be dealt only once when at the 1st pair
% 		if fkc(1,j) ~=0 && j==1
% 			% % Contractions between the masses
% 			xdata_c = [q(1,j)+lcr*vpos_vi2di.x(j),q(3,j)-lcr*vpos_vi2di.x(j)];
% 			ydata_c = [q(2,j)+lcr*vpos_vi2di.y(j),q(4,j)-lcr*vpos_vi2di.y(j)];
% 			line(ax,xdata_c,ydata_c,'Color',cmuscle,'LineWidth',fkc(1,j)/wr+0.5);
% 		end
% 		
% 		% fcv(2) = fc_vii2dii
% 		if fkc(2,j) ~=0
% 			% % Contractions between the masses
% 			xdata_c = [q(1,j+1)+lcr*vpos_vii2dii.x(j),q(3,j+1)-lcr*vpos_vii2dii.x(j)];
% 			ydata_c = [q(2,j+1)+lcr*vpos_vii2dii.y(j),q(4,j+1)-lcr*vpos_vii2dii.y(j)];
% 			line(ax,xdata_c,ydata_c,'Color',cmuscle,'LineWidth',fkc(2,j)/wr+0.5);
% 		end
% 		
% 		% fcv(3) = fc_di2dii
% 		if fkc(3,j) ~= 0
% 			% % Contractions between the masses
% 			xdata_c = [q(3,j)+lcr*vpos_di2dii.x(j),q(3,j+1)-lcr*vpos_di2dii.x(j)];
% 			ydata_c = [q(4,j)+lcr*vpos_di2dii.y(j),q(4,j+1)-lcr*vpos_di2dii.y(j)];
% 			line(ax,xdata_c,ydata_c,'Color',cmuscle,'LineWidth',fkc(3,j)/wr+0.5);
% 		end
% 		
% 		% fc(4) = fc_vi2vii
% 		if fkc(4,j) ~= 0
% 			% % Contractions between the masses
% 			xdata_c = [q(1,j)+lcr*vpos_vi2vii.x(j),q(1,j+1)-lcr*vpos_vi2vii.x(j)];
% 			ydata_c = [q(2,j)+lcr*vpos_vi2vii.y(j),q(2,j+1)-lcr*vpos_vi2vii.y(j)];
% 			line(ax,xdata_c,ydata_c,'Color',cmuscle,'LineWidth',fkc(4,j)/wr+0.5);
% 		end
% 		
% 		% fc(5) = fc_di2vii
% 		if fkc(5,j) ~= 0
% 			% % Contraction between the masses
% 			xdata_c = [q(3,j)+lcr*vpos_di2vii.x(j),q(1,j+1)-lcr*vpos_di2vii.x(j)];
% 			ydata_c = [q(4,j)+lcr*vpos_di2vii.y(j),q(2,j+1)-lcr*vpos_di2vii.y(j)];
% 			line(ax,xdata_c,ydata_c,'Color',cmuscle,'LineWidth',fkc(5,j)/wr+0.5);
% 		end
% 		
% 		if fkc(6,j) ~= 0
% 			% % Contraction between the masses
% 			xdata_c = [q(1,j)+lcr*vpos_vi2dii.x(j),q(3,j+1)-lcr*vpos_vi2dii.x(j)];
% 			ydata_c = [q(2,j)+lcr*vpos_vi2dii.y(j),q(4,j+1)-lcr*vpos_vi2dii.y(j)];
% 			line(ax,xdata_c,ydata_c,'Color',cmuscle,'LineWidth',fkc(6,j)/wr+0.5);
% 		end
% 	end
	
	%% Draw lines that form the octopus shape
	xdata_l = [q(1,:);q(3,:)];
	ydata_l = [q(2,:);q(4,:)];
	line(ax,xdata_l,ydata_l,'Color','k')
	clear xdata_l ydata_l
	
	xdata_l = [q(1,:); q(3,:)].';
	ydata_l = [q(2,:); q(4,:)].';
	line(ax,xdata_l,ydata_l,'Color','k')
	clear xdata_l ydata_l
	
	xdata_l = [q(1,1:end-1);q(3,2:end)];
	ydata_l = [q(2,1:end-1);q(4,2:end)];
	line(ax,xdata_l,ydata_l,'Color','k')
	clear xdata_l ydata_l
	
	xdata_l = [q(3,1:end-1);q(1,2:end)];
	ydata_l = [q(4,1:end-1);q(2,2:end)];
	line(ax,xdata_l,ydata_l,'Color','k')
	clear xdata_l ydata_l
	

	%% Draw masses
	xdata_m = [q(1,:),q(3,:)];
	ydata_m = [q(2,:),q(4,:)];
	
	hold on
	plot(ax,xdata_m,ydata_m,'.k','MarkerSize',45)
	hold off
	
	
	%% Update the figure
	if Has1stPC
		ck = lambda_nsec/LAMBDA_MAX;
		patch(ax,x_ps,y_ps,ck)
	else
		ck = lambda/LAMBDA_MAX;
		patch(ax,x_ps,y_ps,ck)
	end
	
	% Change the display order of the graphic objects
	set(ax,'children',flipud(get(ax,'children')))
	set(ax,'CLim',[0 1])
	set(ax,'CLimMode','manual')
	cmap = flipud(colormap('copper'));
	
	% Specify the colorbar for lambda
	[cm,cn] = size(cmap);
	cmap_red = zeros(cm,cn);
	cmap_red(:,1) = cmap(:,1);
	cmap_red255 = zeros(cm,cn);
	cmap_red255(:,1) = ones(cm,1);
	cmap_white = ones(cm,cn);
	cmap = cmap_white - (cmap_white - cmap)*.55 + (cmap_red255 - cmap_red)*.15;
	colormap(ax,cmap)
	colorbar(ax)
	
 	if Has1stPC
		text(ax,-.05,1.9,['t = ' num2str(t) ' s'])
		text(ax,-.05,1.8, ['\lambda = ' num2str(lambda_nsec.'/LAMBDA_MAX)])
	else
		text(ax,-.4,1.4,['t = ' num2str(t) ' s'])
		text(ax,-.4,1.3, ['\lambda = ' num2str(lambda.'/LAMBDA_MAX)])
	end
	
	%% Draw fext
	fext_q = reshape(fext,4,[]);
	asf = 0.1;
  lr = 0.05;
	x_offset = 0.0;
	y_offset = 0.04;
	
	
	hold on
	[qv_x,qv_y,qv_u,qv_v] = calQuiverPar(q,fext);
	qv_x = qv_x - lr*asf*qv_u + x_offset;
	qv_y = qv_y - lr*asf*qv_v + y_offset;
	qv = quiver(ax,qv_x,qv_y,qv_u,qv_v);
	set(qv,'LineWidth',3)
	set(qv,'AutoScaleFactor',asf)
	set(qv,'MaxHeadSize',0.2)
	hold off
	
	
	%% Add a new frame to the video file
	drawnow
	
	M = getframe(fig);
	[fr_height,fr_width,~] = size(M.cdata);
	if fr_height~=fig_height ||  fr_width~=fig_width
		pause(0.1) % drawnow gives framesize error randomly
		disp('A frameupdate error is detected. Fix it by pausing an extral time.')
		M = getframe(fig);
	end
		
	writeVideo(vid,M)
end

close(vid)
savefig(fig,['Figures/' testcase])
close(fig)
end