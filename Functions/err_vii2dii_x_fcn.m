function [err_vii2dii_x] = err_vii2dii_x_fcn(q)
%ERR_X_DVII_FCN Summary of this function goes here
%   Detailed explanation goes here

% n_sec
n_sec = length(q(1,:)) - 1;

% vec_vi2di
% Mind that the length is equal to n_sec
% The unit vectors vi2di_e are used as references for vii2dii 

qi = q(:,1:end-1); % The last pair will not be used
vpos_vi2di_r    = vpos_vi2di_fcn(qi);
vpos_vi2di_r.ve = [vpos_vi2di_r.x; vpos_vi2di_r.y]./[vpos_vi2di_r.m; vpos_vi2di_r.m];

% vec_vii2dii
% Mind that the length is equal to n_sec

qii = q(:,2:end); % The first pair will not be used
vpos_vii2dii_r   = vpos_vi2di_fcn(qii);
vpos_vii2dii_r.v = [vpos_vii2dii_r.x; vpos_vii2dii_r.y];

% vec_di2vi_p, a vector perpendicular to vec_di2vi
% Rotate 90 degrees clockwise
vec_tmp = rotz(-90)*[vpos_vi2di_r.ve;zeros(1,n_sec)];
vec_vi2di_rotc90_e = vec_tmp(1:2,:);


% err_vii2dii is the projection of vec _vii2dii on vec_di2vi_p_e
err_vii2dii_x = dot(vpos_vii2dii_r.v, vec_vi2di_rotc90_e);

end

