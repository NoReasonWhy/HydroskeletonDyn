function [rvec] = rv_vec_fcn(vec)
%RV_VEC_FCN Summary of this function goes here
%   Detailed explanation goes here

rvec.x = -vec.x;
rvec.y = -vec.y;
rvec.m =  vec.m;
rvec.d =  [];
end

