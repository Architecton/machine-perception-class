% function [Imag, Ilap] = features_maglap(I, sigma, bins)
%
% Partition gradient magnitude matrix and Laplacian of Gaussian matrix into
% bins.
function [Imag, Ilap] = features_maglap(I, sigma, bins)
    Imag = gradient_magnitude(I, sigma);  % Compute gradient maginute matrix of image.
    [imgDxx, ~, imgDyy] = image_derivatives2(I, sigma);  % Compute second partial derivatives of image.
    Ilap = imgDxx + imgDyy;  % Compute laplacian of image (sum of second order derivatives).
	% Set values in gradient magnitude above 100 to 100.
    Imag(Imag > 100) = 100;
	% Partition into bins.
    Imag = floor(Imag * (bins / 101)) + 1;
	
	% Partition laplactian results into bins.
    Ilap = Ilap + 60;
    Ilap(Ilap < 0) = 0;
    Ilap(Ilap > 119) = 119;
    Ilap = floor(Ilap * (bins / 120)) + 1;
end