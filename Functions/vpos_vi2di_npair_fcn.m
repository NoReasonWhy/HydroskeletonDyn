function [vpos_vi2di] = vpos_vi2di_fcn(q,l0)
%VPOS_VI2DI_FCN Summary of this function goes here
%   Detailed explanation goes here

vpos_vi2di = struct;
vpos_vi2di.x = q(3,:) - q(1,:);
vpos_vi2di.y = q(4,:) - q(2,:);
vpos_vi2di.m = sqrt(vpos_vi2di.x.^2 + vpos_vi2di.y.^2);

switch nargin
	case 1
		vpos_vi2di.d = [];
	case 2
		vpos_vi2di.d = vpos_vi2di.m - l0;
end

end