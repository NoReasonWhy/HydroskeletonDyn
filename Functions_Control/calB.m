function [b] = calB(q,L0)
%CALB Summary of this function goes here
%   Detailed explanation goes here

vpos_vi2di    = vpos_vi2di_npair_fcn(q(:,2:end));

b.len = vpos_vi2di.m;

switch nargin
	case 2
		% Positive value is consistent with positive contractrion
		b.errP = b.len - L0;
end

end