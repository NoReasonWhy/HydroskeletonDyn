function [err_di2dii_y] = err_di2dii_y_fcn(q)
%ERR_DII_Y_FCN Summary of this function goes here
%   Detailed explanation goes here

% vpos_di2vi
% Mind the direction
vpos_di2vi = rv_vec_fcn(vpos_vi2di_fcn(q));

% Change to a unit vector: vec_di2vi -> vec_di2vi_e
vpos_di2vi.xe = vpos_di2vi.x ./ vpos_di2vi.m;
vpos_di2vi.ye = vpos_di2vi.y ./ vpos_di2vi.m;

% vpos_di2dii
vpos_di2dii = vpos_di2dii_fcn(q);

% err_dii_y = vec_di2dii's projection on vec_di2vi_e
% Mind the length
err_di2dii_y =	 vpos_di2vi.xe(1:end-1) .* vpos_di2dii.x ...
							 + vpos_di2vi.ye(1:end-1) .* vpos_di2dii.y ;

end