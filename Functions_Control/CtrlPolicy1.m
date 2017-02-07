function [fk,fkc] = CtrlPolicy1(q,err,K)
%CTRLPOLICY1 Control Policy 1: Only regulare alpha and theta
%   Detailed explanation goes here

n_sec = length(q(1,:)) - 1;

%% Obtain K
Kp_alpha = K.Kp.alpha;
Kp_theta = K.Kp.theta;

Kp_alpha_vec = Kp_alpha*ones(n_sec,1);
Kp_theta_vec = Kp_theta*ones(n_sec,1);

%% Bi-direction controller input
fkc_bdir_alpha = Kp_alpha_vec .* err.P.alpha;

fkc_bdir_theta = Kp_theta_vec .* err.P.theta;

%% Reform the bi-dreiction force into individual contractions
[fkc_alpha_p,fkc_alpha_n] = splitContraction(fkc_bdir_alpha,n_sec);
[fkc_theta_p,fkc_theta_n] = splitContraction(fkc_bdir_theta,n_sec);

% Note that the contraction force should always be positve
fkc_alpha_n = abs(fkc_alpha_n);
fkc_theta_n = abs(fkc_theta_n);

%% For contraction force fkc
% fc_vi2di   : 1, ..., n_sec
% fc_vii2dii : 2, ..., n_sec
% fc_di2dii  : 3, ..., n_sec
% fc_vi2vii  : 4, ..., n_sec
% fc_di2vii  : 5, ..., n_sec
% fc_vi2dii  : 6, ..., n_sec

fc_vi2di   = zeros(1,n_sec);
fc_vii2dii = zeros(1,n_sec);
fc_di2dii  = fkc_theta_p;
fc_vi2vii  = fkc_theta_n;
fc_di2vii  = fkc_alpha_p;
fc_vi2dii  = fkc_alpha_n;

fkc = [fc_vi2di; fc_vii2dii; fc_di2dii; fc_vi2vii; fc_di2vii; fc_vi2dii];


%% Recast the contraction forces into the generalised coordinates
fki_alpha = Fi_di2vii_fcn(fkc_alpha_p,q) + Fi_vi2dii_fcn(fkc_alpha_n,q);
fki_theta = Fi_di2dii_fcn(fkc_theta_p,q) + Fi_vi2vii_fcn(fkc_theta_n,q);

%% Form the controller input fk
fk = fki_alpha + fki_theta;

end

