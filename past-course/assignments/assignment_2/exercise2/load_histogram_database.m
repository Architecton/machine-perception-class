% function [histograms, files] = load_histogram_database(directory, bins)
%
% compute histograms of images stored in directory name that is passed as a
% parameter. The function returns the histograms represented as a nxm
% matrix, where n is the number of images and m is the number of bins and a
% cell array that contains the i-th image name in the i-th place.
function [histograms, files] = load_histogram_database(directory, bins)
	files = cell(30 * 4, 1); % We will use cell array to store filenames
	% initialize matrix for histograms
	histograms=zeros(30 * 4, bins^3);
	% calculate histogram for each image
	for i = 1:30 % Iterate objects
		for j = 1:4 % Iterate orientations
			image = (i-1) * 4 + j;		% Compute image index.
			files{image} = fullfile(directory, sprintf('object_%02d_%d.png', i, j));
			H = myhist3_improved(imread(files{image}), bins);	% Compute histogram.
			histograms(image, :) = H(:)';						% Store histogram.
		end
	end