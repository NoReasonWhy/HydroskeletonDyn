function [area] = area_fcn(q)
%AREA_FCN Summary of this function goes here
%   Detailed explanation goes here

n_sec = length(q(1,:))-1;

xv = q(1,:);
yv = q(2,:);
xd = q(3,:);
yd = q(4,:);

area=zeros(1,n_sec);
for i = 1:n_sec
	area(i) = .5*(-xv(i)*yd(i) - xd(i)*yd(i+1)...
									+yv(i)*xd(i) + yd(i)*xd(i+1)...
									-xd(i+1)*yv(i+1) - xv(i+1)*yv(i) ...
									+yd(i+1)*xv(i+1) + yv(i+1)*xv(i));
end

end

