function [fk,fkc] = CtrlPolicy2(q,err,K)
%CTRLPOLICY1 Control Policy 1: Only regulare alpha and theta
%   Detailed explanation goes here

n_sec = length(q(1,:)) - 1;

%% Obtain K
Kp_alpha_vec = K.Kp.alpha*ones(n_sec,1);
Kp_theta_vec = K.Kp.theta*ones(n_sec,1);
Kp_a_vec  = K.Kp.a *ones(n_sec,1); 
Kp_b_vec  = K.Kp.b *ones(n_sec,1);
Kp_ab_vec = K.Kp.ab*ones(n_sec,1);


%% Bi-direction controller input
fkc_bdir_alpha = Kp_alpha_vec .* err.P.alpha.';
fkc_bdir_theta = Kp_theta_vec .* err.P.theta.';
fkc_bdir_a  = Kp_a_vec  .* err.P.a.';
fkc_bdir_b  = Kp_b_vec  .* err.P.b.';
fkc_bdir_ab = Kp_ab_vec .* err.P.ab.';

%% Reform the bi-dreiction force into individual contractions
[fkc_alpha_p,fkc_alpha_n] = splitContraction(fkc_bdir_alpha,n_sec);
[fkc_theta_p,fkc_theta_n] = splitContraction(fkc_bdir_theta,n_sec);
[fkc_a_p, fkc_a_n ] = splitContraction(fkc_bdir_a,n_sec);
[fkc_b_p, fkc_b_n ] = splitContraction(fkc_bdir_b,n_sec);
[fkc_ab_p,fkc_ab_n] = splitContraction(fkc_bdir_ab,n_sec);

% Note that the contraction force should always be positve
fkc_alpha_n = abs(fkc_alpha_n);
fkc_theta_n = abs(fkc_theta_n);
fkc_a_n = abs(fkc_a_n);
fkc_b_n = abs(fkc_b_n);
fkc_ab_n = abs(fkc_ab_n);


%% For contraction force fkc
% fc_vi2di   : 1, ..., n_sec
% fc_vii2dii : 2, ..., n_sec
% fc_di2dii  : 3, ..., n_sec
% fc_vi2vii  : 4, ..., n_sec
% fc_di2vii  : 5, ..., n_sec
% fc_vi2dii  : 6, ..., n_sec

fc_vi2di   = fkc_a_p + fkc_b_n + 0*fkc_ab_p;
fc_vii2dii = fkc_a_n + fkc_b_p + 0*fkc_ab_p;
fc_di2dii  = fkc_theta_p + fkc_ab_n;
fc_vi2vii  = fkc_theta_n + fkc_ab_n;
fc_di2vii  = fkc_alpha_p;
fc_vi2dii  = fkc_alpha_n;

fkc = [fc_vi2di fc_vii2dii fc_di2dii fc_vi2vii fc_di2vii fc_vi2dii].';


%% Recast the contraction forces into the generalised coordinates
fki_alpha = Fi_di2vii_fcn(fkc_alpha_p,q) + Fi_vi2dii_fcn(fkc_alpha_n,q);
fki_theta = Fi_di2dii_fcn(fkc_theta_p,q) + Fi_vi2vii_fcn(fkc_theta_n,q);

fki_a =  [Fi_vi2di_nsec_fcn(fkc_a_p,q);zeros(4,1)] ...
       + [zeros(4,1);Fi_vii2dii_nsec_fcn(fkc_a_n,q)];
		 
fki_b =  [zeros(4,1);Fi_vii2dii_nsec_fcn(fkc_b_p,q)] ...
			 + [Fi_vi2di_nsec_fcn(fkc_b_n,q);zeros(4,1)];
		 
fki_ab = Fi_di2dii_fcn(fkc_ab_n,q) + Fi_vi2vii_fcn(fkc_ab_n,q);

%% Form the controller input fk
fk = fki_alpha + fki_theta + fki_a + fki_b + fki_ab;

end

