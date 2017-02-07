function [Fi_vi2dii] = Fi_vi2dii_fcn(Fc_vi2dii,q)
%FI_VI2DII_FCN Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% [d1  d2  d3  d4  d5  d6] %%%%
%%%% [    /   /   /   /   / ] %%%%
%%%% [  Fc  Fc  Fc  Fc  Fc  ] %%%%
%%%% [	/	  /   /   /   /   ] %%%%
%%%% [v1  v2  v3  v4  v5  v6] %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fc_vi2dii will be processed in the row vector form
if iscolumn(Fc_vi2dii)
	Fc_vi2dii = Fc_vi2dii.';
end

n_pair = length(q(1,:));

% Length of Fc_vi2dii should be n_sec+1
Fi_vi2dii = zeros(4,n_pair); 

vpos_vi2dii = vpos_vi2dii_fcn(q);

Fi_vi2dii(3,2:end  ) = - Fc_vi2dii.*vpos_vi2dii.x ./ vpos_vi2dii.m;
Fi_vi2dii(4,2:end  ) = - Fc_vi2dii.*vpos_vi2dii.y ./ vpos_vi2dii.m;
Fi_vi2dii(1,1:end-1) =   Fc_vi2dii.*vpos_vi2dii.x ./ vpos_vi2dii.m;
Fi_vi2dii(2,1:end-1) =   Fc_vi2dii.*vpos_vi2dii.y ./ vpos_vi2dii.m;

Fi_vi2dii = Fi_vi2dii(:);

end

