function [alpha] = calAlpha(q,Alpha0)
%CALALPHA Summary of this function goes here
%   Detailed explanation goes here

% n_sec
n_sec = length(q(1,:)) - 1;

% vpos_di2vi
% Mind the length
vpos_di2vi = rv_vec_fcn(vpos_vi2di_npair_fcn(q(:,1:end-1)));

% Change to a unit vector: vec_di2vi -> vec_di2vi_e
vpos_di2vi.ve = [vpos_di2vi.x; vpos_di2vi.y]./[vpos_di2vi.m;vpos_di2vi.m];

% vpos_di2dii, and change to a unit vector
vpos_di2dii = vpos_di2dii_fcn(q);
vpos_di2dii.ve = [vpos_di2dii.x;vpos_di2dii.y]./[vpos_di2dii.m;vpos_di2dii.m];


% err_dii_y = vec_di2dii's projection on vec_di2vi_e
cos_alpha = dot(vpos_di2vi.ve, vpos_di2dii.ve);

alpha.angd = acosd(cos_alpha); % alpha angle in degrees

for i = 1:n_sec
	if ~isreal(alpha.angd(i))
		disp('hehe')
	end
	
	if alpha.angd(i) >= 175 || alpha.angd(i) <= 5
		error(['alpha angle (' num2str(i) ') is abnormal'])
	end
end



switch nargin
	case 2
		% Positive value is consistent with positive contraction
		alpha.errP = Alpha0 - alpha.angd;
end

end