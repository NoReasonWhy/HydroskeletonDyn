%% The Main Script for the octopus dynamics
% 1-Section Case
% The contraint acting on the first pair is not applied
% The objective is to identify basic deformation types

clc
close all
clear
addpath('Functions')


%% Specify test cases
% Under the order:
%		vi2di,vii2dii,di2dii,vi2vii,di2vii,vi2dii

% Cases of a single contrction
TestCase{1} = 'test1_Fc_vi2di_' ;
TestCase{2} = 'test2_Fc_di2vii_';

% Cases of a double contraction
TestCase{3} = 'test3_Fc_vi2di_vii2dii_';
TestCase{4} = 'test4_Fc_vi2di_di2dii_' ;
TestCase{5} = 'test5_Fc_vi2di_di2vii_' ; 

% Cases of a triple contraction
TestCase{6}  = 'test6_Fc_vi2di_vii2dii_di2dii_';
TestCase{7}  = 'test7_Fc_vi2di_vii2dii_di2vii_';
TestCase{8}  = 'test8_Fc_vi2di_di2dii_di2vii_' ;
TestCase{9}  = 'test9_Fc_vi2di_di2dii_vi2dii_' ;
TestCase{10} = 'test10_Fc_vi2di_di2vii_vi2dii_' ;

% Cases of a quadruple contraction
TestCase{11} = 'test11_Fc_vi2di_vii2dii_di2dii_vi2vii_';
TestCase{12} = 'test12_Fc_vi2di_vii2dii_di2dii_di2vii_';
TestCase{13} = 'test13_Fc_vi2di_vii2dii_di2vii_vi2dii_';

% Cases of a pentadruple contraction
TestCase{14} = 'test14_Fc_vi2di_vii2dii_di2dii_vi2vii_di2vii_';
TestCase{15} = 'test15_Fc_vi2di_vii2dii_vi2vii_di2vii_vi2dii_';

% Cases of a hexatruple contraction
TestCase{16} = 'test16_Fc_vi2di_vii2dii_di2dii_vi2vii_vi2dii_di2vii_';


%% Setup numerical parameters for simulation
odepar = struct;
odepar.l0 = 1; % Resting length for each edge
odepar.k = 10; % Spring coefficient
odepar.c = 30; % Damping coefficient
odepar.n_sec = 1; % The number of sections
odepar.n_pair = odepar.n_sec+1; % The number of pairs
odepar.n_1pc = 3; % The number of contraints imposing on the 1st pair
odepar.n_err = 2; % Number of error types
odepar.g = 9.81; % m/s^2
odepar.m = 1; % A single mass
odepar.mf = odepar.m*odepar.g; % magnitude of a single contraction force
odepar.mv = odepar.m*ones(1,odepar.n_pair);
odepar.md = odepar.m*ones(1,odepar.n_pair);
odepar.Has1stPairConstraints = false;% Contraints acting on the 1st pair


% Control gains
odepar.Kp = 400; odepar.Pon = 0;
odepar.Ki = 400; odepar.Ion = 0;
odepar.Kd = 400; odepar.Don = 0;


%%%%%%%%%%%%%%%%%%%%
%%%% [xv1, xv2] %%%%
%%%% [yv1, yv2] %%%%
%%%% [xd1, xd2] %%%%
%%%% [yd1, yd2] %%%%
%%%%%%%%%%%%%%%%%%%%
% Initial states
x_pos_ini = [ 0 1
						  0 0
						  0 1
						  1 1
						];
					
x_pos_ini = x_pos_ini(:);
x_vel_ini = zeros(4*(odepar.n_sec+1),1);
x_err_ini = zeros(odepar.n_sec*odepar.n_err,1);
x0 = [x_pos_ini; x_vel_ini; x_err_ini];

% Specify the loads acting on the octopus arm
m = odepar.m;
g = odepar.g;
fext = zeros(4*(odepar.n_sec+1),1);
% fext(8)  = -2*m*g;

odepar.fext = fext;

%% Symbolic derivations
DoesDeriveSymFcns = true;
Has1stPC = odepar.Has1stPairConstraints;
if DoesDeriveSymFcns
	deriveSymFcns(odepar.n_sec,Has1stPC)
end


%% Simulate the dynamics
t = [0 10]; % Simulation time
fps = 30;

parfor i = 1:length(TestCase)
	testcase = TestCase{i};
	disp(testcase)
	odesol = dynamic_solver(odepar,t,x0,testcase);
	odeanimation_fcn(odesol,odepar,fps,testcase)
end


% testcase = TestCase{16};
% disp(testcase)
% odesol = dynamic_solver(odepar,t,x0,testcase);
% odeanimation_fcn(odesol,odepar,fps,testcase)
	
