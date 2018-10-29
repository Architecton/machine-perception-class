% function [Ie] = findedges3(I, sigma, thigh, tlow)
%
% Detect edges using hysteresis tresholding. First get gradient map and
% then apply tresholding.
function [Ie] = findedges3(I, sigma, thigh, tlow)
	% Get gradient map.
	Imag = gradient_magnitude(I, sigma);
	% Apply hysteresis tresholding.
	Ie = hysteresis_tresh(Imag, thigh, tlow);
end