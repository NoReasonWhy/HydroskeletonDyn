function [Fi_vi2vii] = Fi_vi2vii_fcn(Fc_vi2vii,q)
%FI_ Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% [d1    d2    d3    d4    d5    d6] %%%%
%%%% [                                ] %%%%
%%%% [                                ] %%%%
%%%% [		                            ] %%%%
%%%% [v1-Fc-v2-Fc-v3-Fc-v4-Fc-v5-Fc-v6] %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fc_vi2vii will be processed in the row vector form
if iscolumn(Fc_vi2vii)
	Fc_vi2vii = Fc_vi2vii.';
end

n_pair = length(q(1,:));

% The length of Fc_vi2vii is n_sec+1
Fi_vi2vii  = zeros(4,n_pair);

vpos_vi2vii = vpos_vi2vii_fcn(q);

Fi_vi2vii(1,1:end-1) =	 Fc_vi2vii .* vpos_vi2vii.x ./ vpos_vi2vii.m;
Fi_vi2vii(2,1:end-1) =   Fc_vi2vii .* vpos_vi2vii.y ./ vpos_vi2vii.m;
Fi_vi2vii(1,  2:end) = - Fc_vi2vii .* vpos_vi2vii.x ./ vpos_vi2vii.m + Fi_vi2vii(1,2:end);
Fi_vi2vii(2,  2:end) = - Fc_vi2vii .* vpos_vi2vii.y ./ vpos_vi2vii.m + Fi_vi2vii(2,2:end);

% Output Fi_vi2vii in the column vector form
Fi_vi2vii = Fi_vi2vii(:);

end

