function [vvel_vi2dii] = vvel_vi2dii_fcn(dq)
%VVEL_VI2DII_FCN Summary of this function goes here
%   Detailed explanation goes here

vvel_vi2dii.x = dq(3,2:end) - dq(1,1:end-1);
vvel_vi2dii.y = dq(4,2:end) - dq(2,1:end-1);
vvel_vi2dii.m = sqrt(vvel_vi2dii.x.^2 + vvel_vi2dii.y.^2);

end

