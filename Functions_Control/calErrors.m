function [err] = calErrors(q,ref)
%CALERROR Summary of this function goes here
%   Detailed explanation goes here

alpha = calAlpha(q);
theta = calTheta(q);

a = calA(q);
b = calB(q);

err.P.alpha = ref.alpha - alpha.angd;
err.P.theta = ref.theta - theta.angd;

err.P.a  = a.len - ref.a;
err.P.b  = b.len - ref.b;
err.P.ab = err.P.a + err.P.b; 
end

