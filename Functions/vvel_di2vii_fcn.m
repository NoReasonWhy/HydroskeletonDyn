function [vvel_di2vii] = vvel_di2vii_fcn(dq)
%VVEL_DI2VII_FCN Summary of this function goes here
%   Detailed explanation goes here

vvel_di2vii.x = dq(1,2:end) - dq(3,1:end-1);
vvel_di2vii.y = dq(2,2:end) - dq(4,1:end-1);
vvel_di2vii.m = sqrt(vvel_di2vii.x.^2 + vvel_di2vii.y.^2); 

end

