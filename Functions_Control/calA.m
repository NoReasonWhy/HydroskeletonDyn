function [a] = calA(q,L0)
%CALA Summary of this function goes here
%   Detailed explanation goes here

vpos_vi2di    = vpos_vi2di_npair_fcn(q(:,1:end-1));

a.len = vpos_vi2di.m;

switch nargin
	case 2
		% Postive value is consistent with positive contraction
		a.errP = a.len - L0;
end

end