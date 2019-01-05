function h = gaussian_kernel(N,sigma)
%GAUSSIAN_KERNEL Summary of this function goes here
%   Create gaussian kernel
ind = -floor(N/2) : floor(N/2);
[X, Y] = meshgrid(ind, ind);
h = exp(-(X.^2 + Y.^2) / (2*sigma*sigma));
h = h / sum(h(:));
end

