function [x_err] = getxerr_fcn(x,n_sec)
%GETXERR_FCN Summary of this function goes here
%   Detailed explanation goes here

x_pos_len = 4*(n_sec+1);
x_vel_len = x_pos_len;
x_length = length(x);

if x_length > x_pos_len+x_vel_len
	x_err = x(x_pos_len+x_vel_len+1:end);
	
	if isrow(x_err)
		x_err = x_err.';
	end
	
else
	x_err = [];
end

end

