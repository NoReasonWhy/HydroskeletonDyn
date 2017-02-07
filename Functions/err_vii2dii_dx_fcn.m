function [err_vii2dii_dx] = err_vii2dii_dx_fcn(q,dq)
%ERR_X_DVII_FCN Summary of this function goes here
%   Detailed explanation goes here

% n_sec
n_sec = length(q(1,:)) - 1;

% vpos_vi2di_r
% Mind that the length is equal to n_sec
% The unit vectors vi2di_e are used as references for vii2dii 

qi = q(:,1:end-1); % The last pair will not be used
vpos_vi2di_r = vpos_vi2di_fcn(qi);
vpos_vi2di_r.ve = [vpos_vi2di_r.x; vpos_vi2di_r.y]./[vpos_vi2di_r.m; vpos_vi2di_r.m];

% vvel_vii2dii
qii = dq(:,2:end); % The first pair will not be used
vvel_vii2dii_r   = vvel_vi2di_fcn(qii);
vvel_vii2dii_r.v = [vvel_vii2dii_r.x; vvel_vii2dii_r.y];

% vpos_vi2di_p, a vector perpendicular to vec_di2vi
% Rotate 90 degrees clockwise
vec_tmp = rotz(-90)*[vpos_vi2di_r.ve;zeros(1,n_sec)];
vec_vi2di_rotc90_e = vec_tmp(1:2,:);

% err_vii2dii is the projection of vec _vii2dii on vec_di2vi_p_e
err_vii2dii_dx = dot(vvel_vii2dii_r.v, vec_vi2di_rotc90_e);

end

