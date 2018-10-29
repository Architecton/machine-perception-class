% function [Ie] = findedges(I, sigma, theta)
%
% Find edges in image I by tresholding the gradient map. Return matrix
% where ones represent pixels where gradient magnitude values are higher than
% specified treshold.
function [Ie] = findedges(I, sigma, theta)
	% Get gradient map.
	Imag = gradient_magnitude(I, sigma);
	% Apply tresholding.
	Ie = Imag > theta;
end