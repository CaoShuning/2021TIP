function [k] = init_kernel(minsize)
%Init_kernel Summary of this function goes here
%   Initialize the blur kernel with delta function
k = zeros(minsize, minsize);
%   k((minsize - 1)/2, (minsize - 1)/2:(minsize - 1)/2+1) = 1/2;
k((minsize + 1)/2,(minsize + 1)/2) = 1;