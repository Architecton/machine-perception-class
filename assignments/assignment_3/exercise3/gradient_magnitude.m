% function [Imag, Idir] = gradient_magnitude(I, sigma)
%
% Compute matrix of gradient magnitudes	and matrix of derivative angles.
% The gaussian kernel is constructed with a standard deviation of sigma.
function [Imag, Idir] = gradient_magnitude(I, sigma)
	[Ix, Iy] = image_derivatives(I, sigma);  % Compute partial derivatives.
	Imag = sqrt(Ix.^2 + Iy.^2);  % Compute matrix of magnitudes.
	Idir = atan2(Iy, Ix);  % Compute matrix of derivative angles.
end