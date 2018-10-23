% function [feature] = get_gradient_feature(I, sigma)
%
% Get gradient-based feature for an image I. Use gaussian kernel with
% standard deviation of sigma when computing the derivatives.
function [feature] = get_gradient_feature(I, sigma)
	% Allocate array for the feature.
	% The feature is composed of 8*8 histograms of 8 values.
	feature = zeros(1, 512);
	% Define auxiliary index used for storing histograms in feature vector.
	f_idx = 0;
	% Get matrices of gradient magnitudes and derivative directions.
	[Imag, Idir] = gradient_magnitude(I, sigma); 
	% Go over image in 8x8 grids
	for r = 0:7  % Go over rows in grid.
		for c = 0:7  % Go over columns in grid.
			% ### Compute region histogram and add to feature vector. ###
			
			% region indices
			ridx = r*size(I, 1)/8 + 1 : r*size(I, 1)/8 + size(I, 1)/8;
			cidx = c*size(I, 2)/8 + 1 : c*size(I, 2)/8 + size(I, 2)/8;
			% Get bin indices for each pixel.
			[~, ~, bin_indices] = histcounts(Idir(ridx, cidx), 8);
			Mags = Imag(ridx, cidx);  % Get gradient magnitudes for region.
			h = accumarray(bin_indices(:), Mags(:));  % Add magnitudes to bins.
			
			% Add computed histogram to feature vector.
			feature(f_idx*8+1:f_idx*8 + 8) = h;
			f_idx = f_idx + 1;  % Increment feature vector counter.
			% ###########################################################
		end
	end
end
	