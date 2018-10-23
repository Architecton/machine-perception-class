% function [Ixx, Iyy, Ixy] = image_derivatives2(I, sigma)
%
% Compute second partial derivatives of image I where the gaussian kernel is
% constructed using a standard deviation equal to sigma.
function [Ixx, Iyy, Ixy] = image_derivatives2(I, sigma)
	[Ix, Iy] = image_derivatives(I, sigma);  % Compute first order derivatives.
	[Ixx, Ixy] = image_derivatives(Ix, sigma);  % Compute second order derivatives.
	[~, Iyy] = image_derivatives(Iy, sigma);
end