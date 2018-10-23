% function [files] = load_histogram_database(directory)
%
% Compute a cell array of file names of image files stored in specified
% directory.
%
function [files] = load_database_filenames(directory)
	files = cell(30 * 4, 1); % We will use cell array to store filenames
	for i = 1:30  % Iterate objects
		for j = 1:4  % Iterate orientations
			image = (i-1) * 4 + j;		% Compute image index.
			files{image} = fullfile(directory, sprintf('object_%02d_%d.png', i, j));
		end
	end