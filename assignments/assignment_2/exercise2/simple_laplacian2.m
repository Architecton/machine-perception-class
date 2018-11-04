% function res = simple_laplacian2(I)
%
% Apply laplacian operator to image I.
% The kernel is obtained from the built int fspecial function.
function res = simple_laplacian2(I)
	 h = [0.25 0.5 0.25; 0.5 -3 0.5; 0.25 0.5 0.25];  % Get kernel that approximates the laplacian operator.
	%h = fspecial('laplacian');
	res = uint8(conv2(I, h));		% Compute convolution of image with kernel.
	res = res(2:end-1, 2:end-1);
end