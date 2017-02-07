function [Fi_di2dii] = Fi_di2dii_fcn(Fc_di2dii,q)
%FI_DI2DII_FCN Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% [d1-Fc-d2-Fc-d3-Fc-d4-Fc-d5-Fc-d6] %%%%
%%%% [                                ] %%%%
%%%% [                                ] %%%%
%%%% [		                            ] %%%%
%%%% [v1    v2    v3    v4    v5    v6] %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fc_di2dii will be processed in the row vector form
if iscolumn(Fc_di2dii)
	Fc_di2dii = Fc_di2dii.';
end

n_pair = length(q(1,:));

% The length of Fi_di2dii is n_pair
Fi_di2dii = zeros(4,n_pair);

vpos_di2dii = vpos_di2dii_fcn(q);

Fi_di2dii(3,1:end-1) =	 Fc_di2dii .* vpos_di2dii.x ./ vpos_di2dii.m;
Fi_di2dii(4,1:end-1) =   Fc_di2dii .* vpos_di2dii.y ./ vpos_di2dii.m;
Fi_di2dii(3,2:  end) = - Fc_di2dii .* vpos_di2dii.x ./ vpos_di2dii.m + Fi_di2dii(3,2:end);
Fi_di2dii(4,2:  end) = - Fc_di2dii .* vpos_di2dii.y ./ vpos_di2dii.m + Fi_di2dii(4,2:end);

% Output Fi_di2dii in the column vector form
Fi_di2dii = Fi_di2dii(:);

end

