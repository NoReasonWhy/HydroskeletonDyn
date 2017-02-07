function [x_pos] = getxpos_fcn(x,n_sec)
%GETXPOS_FCN Obtain the zero order entry from the state variable x
%   x is the state variable used in the octopus model

x_pos_len = 4*(n_sec+1);
x_pos     = x(1:x_pos_len);

if isrow(x_pos)
	x_pos = x_pos.';
end

end

