function [ q_vec ] = q_mat2vec_fcn(q_mat)
%Q_MAT2VEC_FCN Summary of this function goes here
%   Detailed explanation goes here

[m,n]=size(q_mat);

q_vec = zeros(m*n,1);

for i=1:m
	q_vec(1+n*(i-1):n*i,1) = transpose(q_mat(i,:));
end


end

