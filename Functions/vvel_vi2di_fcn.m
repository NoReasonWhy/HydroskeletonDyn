function [vvel_vi2di] = vvel_vi2di_fcn(dq)
%VVEL_VI2DI_FCN Summary of this function goes here
%   Detailed explanation goes here

vvel_vi2di.x = dq(3,:) - dq(1,:);  % Xv
vvel_vi2di.y = dq(4,:) - dq(2,:);  % Yv
vvel_vi2di.m = sqrt(vvel_vi2di.x.^2 + vvel_vi2di.y.^2);

end

