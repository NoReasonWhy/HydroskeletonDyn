function [fc_p,fc_n] = splitContraction_fcn(fc,n_sec)
%SPLITCONTRACTION_FCN Summary of this function goes here
%   Detailed explanation goes here

if isrow(fc)
	fc = fc.';
end

fc_p = zeros(n_sec,1);
fc_n = zeros(n_sec,1);

for i = 1:n_sec
	if fc(i) >= 0
		fc_p(i) = fc(i);
	else
		fc_n(i) = fc(i);
	end
end

end

