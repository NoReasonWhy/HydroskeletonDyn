function deriveSymFcns(n_sec,Has1stPairConstraints)
% Create M-functions for the ode

%% Setup the basic numerical parameters
% The number of pairs
n_pair = n_sec + 1;

% The number of contraints imposing on the 1st pair
if Has1stPairConstraints
	n_1pc = 3;
else
	n_1pc = 0;
end


%% Kinematics for the octopus arm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SCHEMATICS OF THE QUALITATIVE OCTOPUS ARM %%%%
%%%% ----------------------------------------- %%%%
%%%%    pair: 1    2    3    4    5    6       %%%%
%%%% ----------------------------------------- %%%% 
%%%%  section:   1    2    3    4    5				 %%%%
%%%% ----------------------------------------- %%%%
%%%%  				d1   d2   d3   d4   d5   d6      %%%%
%%%%  dorsal:	o----o----o----o----o----o       %%%%
%%%% 					|    |    |    |    |    |			 %%%%
%%%% 					|	   |    |    |    |    |	     %%%%
%%%% ventral:	o----o----o----o----o----o       %%%%
%%%%					v1   v2   v3   v4   v5   v6      %%%%
%%%% ----------------------------------------- %%%%
%%%% 				[xv1, xv2, xv3, xv4, xv5, xv6]     %%%%
%%%% 				[yv1, yv2, yv3, yv4, yv5, yv6]		 %%%%
%%%% 				[xd1, xd2, xd3, xd4, xd5, xd6]	   %%%%
%%%% 				[yd1, yd2, yd3, yd4, yd5, yd6]		 %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Position terms
xv = sym('xv',[1,n_pair]);
yv = sym('yv',[1,n_pair]);
xd = sym('xd',[1,n_pair]);
yd = sym('yd',[1,n_pair]);

% Velocity terms
dxv = sym('dxv',[1,n_pair]);
dyv = sym('dyv',[1,n_pair]);
dxd = sym('dxd',[1,n_pair]);
dyd = sym('dyd',[1,n_pair]);

% Position terms in the state variable x
q = [xv; yv; xd; yd];

% Position state as M-function input
x_pos = q(:); % A row vector is required
x_pos_len = length(q(:));

% Velocity terms in the state varaible dx
dq = [dxv; dyv; dxd; dyd];	

% Velocity state as M-function input
x_vel = dq(:); % A row vector is required

% Mechnical paramters
mv = sym('mv',[1,n_pair]);
md = sym('md',[1,n_pair]);
k  = sym('k' ); % Stiffness
L0 = sym('L0'); % Resting length
c  = sym('c' ); % Damping

% lambda(1:n_sec) is induced from the constant area constraint
% lambda(n_sec:n_sec+n_1pc) is induced from the 1st pair constraint
lambda = sym('lambda',[n_sec+n_1pc,1]);

% Areas for the individual sections
area = sym('area',[n_sec,1]);
for i = 1:n_sec
	area(i,1) = .5*( - xv(i)*yd(i)     - xd(i)*yd(i+1) ...
									 + yv(i)*xd(i)     + yd(i)*xd(i+1) ...
									 - xd(i+1)*yv(i+1) - xv(i+1)*yv(i) ...
									 + yd(i+1)*xv(i+1) + yv(i+1)*xv(i) );
end


%% Refer to the appendix of Yekutieli, et al. (2015)
% Form the PFaffian equations and extract
if Has1stPairConstraints
	D1 = jacobian(area,x_pos);
	D2 = jacobian(x_pos([1,3,4],1),x_pos(:));
	D  = [D1;D2];
else
	D = jacobian(area,x_pos);
end

%% G
G = sym('G',[n_sec+n_1pc,x_pos_len]);
for i = 1:n_sec+n_1pc
    G(i,:) = D(i,:) + (jacobian(D(i,:),x_pos)*x_pos).';
end


%% gamma
gamma = sym('gamma',[n_sec+n_1pc,1]);
for i = 1:n_sec+n_1pc
    gamma(i,1) = -2*(jacobian(D(i,:),x_pos)*x_vel).'*x_vel;
end


%% C
C = D.';


%% fc: the internal forcs induced by the constraints
fc = C*lambda;
 
%% Create Mass Matrix
M = [mv; mv; md; md];
M = diag(M(:));


%% Obtain the postion vectors that form the octopus arm
vpos_di2dii = vpos_di2dii_fcn(q,L0); % Vector di2dii
vpos_vi2vii = vpos_vi2vii_fcn(q,L0); % Vector vi2vii
vpos_vi2di  = vpos_vi2di_fcn (q,L0); % Vector vi2di 
vpos_di2vii = vpos_di2vii_fcn(q,L0); % Vector di2vii 
vpos_vi2dii = vpos_vi2dii_fcn(q,L0); % Vector vi2dii


%% Obtain the velocity vectors from the octopus arm
vvel_di2dii = vvel_di2dii_fcn(dq); % Velocity vector di2dii
vvel_vi2vii = vvel_vi2vii_fcn(dq); % Velocity vector vi2vii
vvel_vi2di  = vvel_vi2di_fcn (dq); % Velocity vector vi2di
vvel_di2vii = vvel_di2vii_fcn(dq); % Velocity vector di2vii 
vvel_vi2dii = vvel_vi2dii_fcn(dq); % Velocity vector vi2dii


%% Calculate the spring stiffness matrix
% Spring Energy
Ps =  .5*k*sum(vpos_di2dii.d.^2) ...
		 +.5*k*sum(vpos_vi2vii.d.^2) ...
		 +.5*k*sum(vpos_vi2di.d .^2) ...
		 +.5*k*sum(vpos_di2vii.d.^2) ...
		 +.5*k*sum(vpos_vi2dii.d.^2) ;

% Spring force
fs = jacobian(Ps,x_pos).'; 
 

%% Calculate the Dampening matrix
% Virtual energy
Pd =  .5*c*sum(vvel_di2dii.m.^2) ...
		 +.5*c*sum(vvel_vi2vii.m.^2) ...
		 +.5*c*sum(vvel_vi2di.m .^2) ...
		 +.5*c*sum(vvel_di2vii.m.^2) ...
		 +.5*c*sum(vvel_vi2dii.m.^2) ;

% Damping force
fd = jacobian(Pd,x_vel).';


%% Create Matlab functions
mfunc = @matlabFunction;
str1 = 'Functions_ODE/';
str2 = '_fcn_sec';
mfunc(M, 'File', [str1 'M' str2 num2str(n_sec)], 'Vars',{mv,md});
mfunc(fc,'File', [str1 'fc' str2 num2str(n_sec)],'Vars',{lambda,x_pos});
mfunc(G, 'File', [str1 'G' str2 num2str(n_sec)], 'Vars',{x_pos});
mfunc(C, 'File', [str1 'C' str2 num2str(n_sec)], 'Vars',{x_pos});
mfunc(gamma,'File', [str1 'gamma' str2 num2str(n_sec)], 'Vars',{x_vel});
mfunc(fs,'File', [str1 'fs' str2 num2str(n_sec)],'Vars',{k,L0,x_pos});
mfunc(fd,'File', [str1 'fd' str2 num2str(n_sec)],'Vars',{c,x_vel});