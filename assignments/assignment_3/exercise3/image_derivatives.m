% function [Ix, Iy] = image_derivatives(I, sigma)
% 
% Compute partial derivatives of image I. The gaussian kernel is
% constructed using a standard deviation of sigma.
function [Ix, Iy] = image_derivatives(I, sigma)
	dg = gaussdx(sigma); % Compute kernels.
	g = gauss(sigma);
	% Ix = conv2(conv2(I, g'), dg); % Derivative with respect to x.
	% Iy = conv2(conv2(I, dg'), g); % Derivative with respect to y.
	% Equivalent!
	Ix = conv2(g, dg, I, 'same'); % Derivative with respect to x.
	Iy = conv2(dg, g, I, 'same'); % Derivative with respect to y.
end