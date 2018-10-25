% function [Ie] = hysteresis_tresh(I, sigma, thigh, tlow)
%
% Apply histeresis tresholding to image I and return result.
function [Ie] = hysteresis_tresh(I, sigma, thigh, tlow)
	% Get gradient magnitude.
	Imag = gradient_magnitude(I, sigma);
	% Get regions that are above the high treshold.
	high_mask = Imag>thigh; 
	% Label regions that pass the low treshold.
	low_mask = bwlabel(Imag > tlow);
	% From low_mask get values that are also in high mask and find
	% corresponding labels. Get regions where the labels are found in the
	% low_mask.
	F = ismember(low_mask, unique(low_mask(high_mask)));
	
	% Allocate matrix for resut.
	Ie = zeros(size(Imag));
	% Get indices of resulting edge areas.
	idx = find(F);
	Ie(idx) = Imag(idx); % Add appropriate pixels to results matrix.
end