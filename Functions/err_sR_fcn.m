function [err_sL] = err_sR_fcn(q,l0)
%ERR_SL_FCN Summary of this function goes here
%   Detailed explanation goes here

vpos_vi2di = vpos_vi2di_npair_fcn(q,l0);

err_sL = vpos_vi2di.d(2:end);

end

