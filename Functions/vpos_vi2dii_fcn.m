function [vpos_vi2dii] = vpos_vi2dii_fcn(q,L0)
%VPOS_VI2DII_FCN Summary of this function goes here
%   Detailed explanation goes here

vpos_vi2dii = struct;
vpos_vi2dii.x = q(3,2:end) - q(1,1:end-1);
vpos_vi2dii.y = q(4,2:end) - q(2,1:end-1);
vpos_vi2dii.m = sqrt(vpos_vi2dii.x.^2 + vpos_vi2dii.y.^2);

switch nargin
	case 1
		vpos_vi2dii.d = [];
	case 2
		vpos_vi2dii.d = vpos_vi2dii.m - sqrt(2)*L0;
end

end