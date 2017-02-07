function [theta] = calTheta(q,Theta0)
%CALTHETA Summary of this function goes here
%   Detailed explanation goes here

% n_sec
n_sec = length(q(1,:)) - 1;

% vec_vi2di
% The last pair will not be used
vpos_vi2di    = vpos_vi2di_npair_fcn(q(:,1:end-1));
vpos_vi2di.ve = [vpos_vi2di.x; vpos_vi2di.y]./[vpos_vi2di.m; vpos_vi2di.m];

% vec_vi2di_rotc90 by a counter-clockwise rotation
vpos_tmp = rotz(90)*[vpos_vi2di.ve;zeros(1,n_sec)];
vpos_vi2di_rotc90.ve = vpos_tmp(1:2,:);

% vec_vii2dii
% The first pair will not be used
vpos_vii2dii    = vpos_vi2di_fcn(q(:,2:end));
vpos_vii2dii.ve = [vpos_vii2dii.x; vpos_vii2dii.y]./[vpos_vii2dii.m; vpos_vii2dii.m];

% Calculate the intersection angles
cos_theta = dot(vpos_vi2di.ve,vpos_vii2dii.ve);
% % Avoid over-1 errors - 1 degree tolerance
for i = 1:n_sec
	 if cos_theta(i)-1>0
		cos_theta(i) = 1;
	end
end

theta.angd = acosd(cos_theta);

% the sign of theta is determined by the reference vec_vi2di_rotc90
cos_theta_rotc90 = dot(vpos_vi2di_rotc90.ve, vpos_vii2dii.ve);
theta.angd_rotc90 = acosd(cos_theta_rotc90);

for i = 1:n_sec
	if theta.angd_rotc90(i) > 90
		theta.angd(i) = - theta.angd(i);
	end
	
	if ~isreal(theta.angd(i))
		disp('hehe')
	end
	
	if theta.angd(i) < -85 || theta.angd(i) > 85
		error(['theta angle (' num2str(i) ') is abnormal'])
	end
end

% disp(theta.angd)
switch nargin
	case 2
		% Postive value is consistent with positive contraction
		theta.errP = Theta0 - theta.angd; 
end

end