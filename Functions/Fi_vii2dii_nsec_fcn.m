function [Fi_vii2dii_nsec] = Fi_vii2dii_nsec_fcn(Fc_vi2di,q)
%FI_VI2DI Summary of this function goes here
%   Detailed explanation goes here

% The (n_sec+1)th pair is left
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% [d1  d2  d3  d4  d5  d6] %%%%
%%%% [ |   |   |   |   |    ] %%%%
%%%% [Fc  Fc  Fc  Fc  Fc  FC] %%%%
%%%% [ |	 |   |   |   |    ] %%%%
%%%% [v1  v2  v3  v4  v5  v6] %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Fc_vi2di will be processed in the row vector form
if iscolumn(Fc_vi2di)
	Fc_vi2di = Fc_vi2di.';
end

n_sec = length(q(1,:))-1;

if n_sec ~= length(Fc_vi2di)
	error('Fc_vi2di_nsec size is wrong.')
end

% Length of Fc_vi2di should be n_sec+1
Fi_vii2dii_nsec = zeros(4,n_sec);

vpos_vi2di = vpos_vi2di_npair_fcn(q(:,2:end));

Fi_vii2dii_nsec(1,:) = Fc_vi2di.*vpos_vi2di.x./vpos_vi2di.m;
Fi_vii2dii_nsec(2,:) = Fc_vi2di.*vpos_vi2di.y./vpos_vi2di.m;
Fi_vii2dii_nsec(3,:) = - Fi_vii2dii_nsec(1,:);
Fi_vii2dii_nsec(4,:) = - Fi_vii2dii_nsec(2,:);

% Output Fi_vi2di in the column vector form
Fi_vii2dii_nsec = Fi_vii2dii_nsec(:);

end

