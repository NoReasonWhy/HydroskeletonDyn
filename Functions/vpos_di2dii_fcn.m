function [vpos_di2dii] = vpos_di2dii_fcn(q,L0)
%VPOS_DI2DII_FCN Summary of this function goes here
%   Detailed explanation goes here

vpos_di2dii = struct;
vpos_di2dii.x = q(3,2:end) - q(3,1:end-1);  
vpos_di2dii.y = q(4,2:end) - q(4,1:end-1);
vpos_di2dii.m = sqrt(vpos_di2dii.x.^2 + vpos_di2dii.y.^2);

switch nargin
	case 1
		vpos_di2dii.d = [];
	case 2
		vpos_di2dii.d = vpos_di2dii.m - L0;
end

end

