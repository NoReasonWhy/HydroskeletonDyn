function [x,y,u,v] = calQuiverPar(q,fext)
%CALQUIVERPAR Summary of this function goes here
%   Detailed explanation goes here
qx = [q(1,:);q(3,:)];
x = qx(:);

qy = [q(2,:);q(4,:)];
y = qy(:);

f = reshape(fext,2,[]);
u = f(1,:).';
v = f(2,:).';
end

