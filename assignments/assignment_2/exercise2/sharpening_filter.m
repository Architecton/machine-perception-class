% function [Is] = sharpening_filter(I)
%
% Apply sharpening filter to image I and return the result.
function [Is] = sharpening_filter(I)
	% Compute convolution kernel.
	h = [0 0 0; 0 2 0; 0 0 0] - 1/9 * ones(3, 3);
	% Perform filtering.
	Is = imfilter(I, h, 'conv', 'same');
end