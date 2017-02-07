function [x_vel] = getxvel_fcn(x,n_sec)
%GETXVEL_FCN Obtain the zero order entry from the state variable x
%   x is the state variable used in the octopus model

x_pos_len = 4*(n_sec+1);
x_vel_len = x_pos_len;
x_vel     = x(x_pos_len+1:x_pos_len+x_vel_len);

if isrow(x_vel)
	x_vel = x_vel.';
end

end

