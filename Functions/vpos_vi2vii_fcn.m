function [vpos_vi2vii] = vpos_vi2vii_fcn(q,L0)
%VPOS_VI2VII_FCN Summary of this function goes here
%   Detailed explanation goes here

vpos_vi2vii = struct;
vpos_vi2vii.x = q(1,2:end) - q(1,1:end-1);    
vpos_vi2vii.y = q(2,2:end) - q(2,1:end-1);
vpos_vi2vii.m = sqrt(vpos_vi2vii.x.^2 + vpos_vi2vii.y.^2);

switch nargin
	case 1
		vpos_vi2vii.d = [];
	case 2
		vpos_vi2vii.d = vpos_vi2vii.m - L0;
end


end

