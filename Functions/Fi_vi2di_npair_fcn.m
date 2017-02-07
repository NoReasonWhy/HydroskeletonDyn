function [Fi_vi2di] = Fi_vi2di_npair_fcn(Fc_vi2di,q)
%FI_VI2DI Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% [d1  d2  d3  d4  d5  d6] %%%%
%%%% [ |   |   |   |   |   |] %%%%
%%%% [Fc  Fc  Fc  Fc  Fc  FC] %%%%
%%%% [ |	 |   |   |   |   |] %%%%
%%%% [v1  v2  v3  v4  v5  v6] %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fc_vi2di will be processed in the row vector form
if iscolumn(Fc_vi2di)
	Fc_vi2di = Fc_vi2di.';
end

n_pair = length(q(1,:));

% Length of Fc_vi2di should be n_sec+1
Fi_vi2di = zeros(4,n_pair);

vpos_vi2di = vpos_vi2di_fcn(q);

Fi_vi2di(1,:) = Fc_vi2di.*vpos_vi2di.x./vpos_vi2di.m;
Fi_vi2di(2,:) = Fc_vi2di.*vpos_vi2di.y./vpos_vi2di.m;
Fi_vi2di(3,:) = - Fi_vi2di(1,:);
Fi_vi2di(4,:) = - Fi_vi2di(2,:);

% Output Fi_vi2di in the column vector form
Fi_vi2di = Fi_vi2di(:);

end

