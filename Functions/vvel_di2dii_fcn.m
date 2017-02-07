function [vvel_di2dii] = vvel_di2dii_fcn(dq)
%VVEL_ Summary of this function goes here
%   Detailed explanation goes here

vvel_di2dii.x = dq(3,2:end) - dq(3,1:end-1);
vvel_di2dii.y = dq(4,2:end) - dq(4,1:end-1);
vvel_di2dii.m = sqrt(vvel_di2dii.x.^2 + vvel_di2dii.y.^2);

end