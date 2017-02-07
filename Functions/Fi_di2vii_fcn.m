function [Fi_di2vii] = Fi_di2vii_fcn(Fc_di2vii, q)
%FI_DI2VII_FCN Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% [d1  d2  d3  d4  d5  d6] %%%%
%%%% [ \   \   \   \   \    ] %%%%
%%%% [  Fc  Fc  Fc  Fc  Fc  ] %%%%
%%%% [		\   \   \   \   \ ] %%%%
%%%% [v1  v2  v3  v4  v5  v6] %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fc_vi2dii will be processed in the row vector form
if iscolumn(Fc_di2vii)
	Fc_di2vii = Fc_di2vii.';
end

n_pair = length(q(1,:));

% Length of Fc_di2vii should be n_sec+1
Fi_di2vii = zeros(4,n_pair); 

vpos_di2vii = vpos_di2vii_fcn(q);

Fi_di2vii(1,2:end  ) = - Fc_di2vii .* vpos_di2vii.x ./ vpos_di2vii.m;
Fi_di2vii(2,2:end  ) = - Fc_di2vii .* vpos_di2vii.y ./ vpos_di2vii.m;
Fi_di2vii(3,1:end-1) =   Fc_di2vii .* vpos_di2vii.x ./ vpos_di2vii.m;
Fi_di2vii(4,1:end-1) =   Fc_di2vii .* vpos_di2vii.y ./ vpos_di2vii.m;

Fi_di2vii = Fi_di2vii(:);

end

