function [vvel_vi2vii] = vvel_vi2vii_fcn(dq)
%VVEL_VI2VII_FCN Summary of this function goes here
%   Detailed explanation goes here

vvel_vi2vii.x = dq(1,2:end) - dq(1,1:end-1); 
vvel_vi2vii.y = dq(2,2:end) - dq(2,1:end-1);
vvel_vi2vii.m = sqrt(vvel_vi2vii.x.^2 + vvel_vi2vii.y.^2);

end

