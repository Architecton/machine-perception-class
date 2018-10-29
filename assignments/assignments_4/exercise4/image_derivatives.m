% function [Ix, Iy] = image_derivatives(I, sigma)
% 
% Compute partial derivatives of image I. The gaussian kernel is
% constructed using a standard deviation of sigma.
function [Ix, Iy] = image_derivatives(I, sigma)
	dg = gaussdx(sigma); % Compute kernels.
	g = gauss(sigma);
	h1 = conv2(g', dg); % Prepare kernels for imfilter (has the 'replicate' option)
	h2 = conv2(dg', g);
	Ix = imfilter(double(I), h1, 'conv', 'same', 'replicate'); % Derivative with respect to x.
	Iy = imfilter(double(I), h2, 'conv', 'same', 'replicate'); % Derivative with respect to y.
	% Similar but may treat image borders as edges.
	% Ix = conv2(g, dg, I, 'same'); % Derivative with respect to x.
	% Iy = conv2(dg, g, I, 'same'); % Derivative with respect to y.
end