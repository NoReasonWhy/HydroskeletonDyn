function sol = dynamic_solver(odepar,t,x0,testcase)

%% Setup parameters
n_sec = odepar.n_sec;
n_pair = n_sec+1;
mv = odepar.mv;
md = odepar.md;
k = odepar.k;
c = odepar.c;
l0 = odepar.l0;
fext =odepar.fext;
mf = odepar.mf;
K = odepar.K;


%% IsDisplayOn
IsDisplayOn_t      = true;
IsDisplayOn_area   = false;
IsDisplayOn_lambda = false;
IsDisplayOn_alpha  = true;
IsDisplayOn_theta  = true;
IsDisplayOn_a      = false;
IsDisplayOn_b      = false;
IsDisplayOn_Err    = false;
IsDisplayOn_fkc    = false;

%% Evalution
sol = ode45(@Dynamic,t,x0);

	function dx = Dynamic(t,x)
		%% x_pos, x_vel, q, dq
		x_pos = getxpos_fcn(x,n_sec);
		x_vel = getxvel_fcn(x,n_sec);
		
		x_pos_len = length(x_pos);
		x_vel_len = length(x_vel);
		
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%%%% [xv1, xv2, xv3, xv4, xv5, xv6] %%%%
		%%%% [yv1, yv2, yv3, yv4, yv5, yv6] %%%%
		%%%% [xd1, xd2, xd3, xd4, xd5, xd6] %%%%
		%%%% [yd1, yd2, yd3, yd4, yd5, yd6] %%%%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		q = reshape(x_pos,4,n_pair);
		dq = reshape(x_vel,4,n_pair);
		
		
		%% Control
		ref.alpha = 95;
		ref.theta = 5;
		l0 = l0;
		ref.a = l0;
		ref.b = l0;
		
		% Calculate errors
		err = calErrors(q,ref);
		
		% Calcuate controller input
		[fk,fkc] = CtrlPolicy3(q,err,K);
		
		
		%% Specify ftest according to testcase
		ftest = SelTestCase(testcase,mf,q);
		
		%% Calculate forces acting on the masses
		M_fcn = str2func(['M_fcn_sec' num2str(n_sec)]);
		G_fcn = str2func(['G_fcn_sec' num2str(n_sec)]);
		C_fcn = str2func(['C_fcn_sec' num2str(n_sec)]);
		gamma_fcn = str2func(['gamma_fcn_sec' num2str(n_sec)]);
		fs_fcn = str2func(['fs_fcn_sec' num2str(n_sec)]);
		fd_fcn = str2func(['fd_fcn_sec' num2str(n_sec)]);
		fc_fcn = str2func(['fc_fcn_sec' num2str(n_sec)]);
		
		M = M_fcn(mv,md);
		G = G_fcn(x_pos);
		C = C_fcn(x_pos);
		gamma = gamma_fcn(x_vel);
		
		% Calculate the forces induced by the springs
		fs = fs_fcn(k,l0,x_pos);

		% Calculate the friciton forces
		fd = fd_fcn(c,x_vel);
		
		% Caculate the constraint forces
		lambda = (G*(M\C))\(gamma - G*(M\(fext+fk-fs-fd)));
		fc = fc_fcn(lambda,x(1:x_pos_len));
		
		%% Update dx
		dx = zeros(x_pos_len+x_vel_len,1);
		
		dx(1:x_pos_len)                     = x_vel;
		dx(x_pos_len+1:x_pos_len+x_vel_len) = M\(fc+fext+fk-fs-fd);
		
		%% IsDisplayOn
		if IsDisplayOn_t
			disp(['t = ' num2str(t)])
		end
		
		if IsDisplayOn_area
			disp(['area: ' num2str(area_fcn(q))])
		end
		
		if IsDisplayOn_lambda
			disp(['lambda: ' num2str(lambda.')])
		end
		
		if IsDisplayOn_alpha
			alpha = calAlpha(q);
			disp(['alpha: ' num2str(alpha.angd)])
		end
		
		if IsDisplayOn_theta
			theta = calTheta(q);
			disp(['theta: ' num2str(theta.angd)])
		end
		
		if IsDisplayOn_a
			a = calA(q);
			disp(['a: ' num2str(a.len)])
		end
		
		if IsDisplayOn_b
			b = calB(q);
			disp(['b = ' num2str(b.len)])
		end
		
		if IsDisplayOn_Err
			disp(['alpha error: ' num2str(err.P.alpha)])
			disp(['theta error: ' num2str(err.P.theta)])
			disp(['a error: ' num2str(err.P.a)]);
			disp(['b_error: ' num2str(err.P.b)]);
		end
		
		if IsDisplayOn_fkc
			disp('fkc')
			disp(fkc)
		end
	end

end

