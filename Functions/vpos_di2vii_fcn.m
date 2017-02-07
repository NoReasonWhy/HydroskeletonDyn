function [vpos_di2vii] = vpos_di2vii_fcn(q,L0)
%VPOS_DI2VII_FCN Summary of this function goes here
%   Detailed explanation goes here

vpos_di2vii = struct;
vpos_di2vii.x = q(1,2:end) - q(3,1:end-1);
vpos_di2vii.y = q(2,2:end) - q(4,1:end-1);
vpos_di2vii.m = sqrt(vpos_di2vii.x.^2 + vpos_di2vii.y.^2);

switch nargin
	case 1
		vpos_di2vii.d = [];
	case 2
		vpos_di2vii.d = vpos_di2vii.m - sqrt(2)*L0;
end

end

