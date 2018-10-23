% function [H, bins] = myhist(I, nbins) 
%
% Compute histogram of image I using nbins bins. Return the bins and the
% values of the bins.
function [H, bins] = myhist(I, nbins)
	I = reshape(I, 1, numel(I));	% Reshape image to 1-D vector.
	H = zeros(1, nbins);			% Initialize histogram (all zeros).
	max_val_in = 255;				% highest input values
	min_val_in = 0;					% lowest input value
	max_val_out = nbins;			% highest cell index
	min_val_out = 1;				% lowest cell index
	
	% Compute bin numbers for all pixels.
	f = (max_val_out - min_val_out) / (max_val_in - min_val_in);
	idx = floor(double(I) * f) + min_val_out; % Compute indices for all pixels.
	idx(idx > nbins) = nbins;				  % Truncate the outliers.
	for i = 1:length(I)						  % Iterate over image.
		H(idx(i)) = H(idx(i)) + 1;			  % Increment value in appropriate cell.
	end
	
	% Normalize the histogram (sum of cell values equals 1)
	H = H / sum(H);
	
	% Compute reference values for all cells in the histogram
	bins = ((1 : nbins) - min_val_out) ./ f;
end