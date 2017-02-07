function [ err_o ] = rm_positives_fcn(err_i)
%RM_NEGATIVES_FCN Summary of this function goes here
%   Detailed explanation goes here

if iscolumn(err_i)
	err_i = err_i.';
end

err_o = zeros(1,length(err_i));

for i=1:length(err_i)
	if err_i(i)>0
		err_o(i)=0;
	else
		err_o(i)=err_i(i);
	end
end

end

