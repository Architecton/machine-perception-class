function [out_rho, out_theta] = hough_find_lines(Ie, bins_rho, bins_theta, threshold)
	% max_rho = length(diag(Ie)); % Set maximum value of rho equal to image diagonal length.
	max_rho = hypot(size(Ie, 1), size(Ie, 2));
	idx_edges = find(Ie > 1e-2);  % Find indices of nonzero elements in Ie matrix.
	val_theta = (linspace(-90, 90, bins_theta) / 180) * pi; % Values of theta are known
	val_rho = linspace(-max_rho, max_rho, bins_rho); % Partition interval [-max_rho, max_rho] into bins_rho bins
	A = zeros(bins_rho, bins_theta);  % Define accumulator matrix.
	
	% Get x and y values from linear indices.
	[x, y] = ind2sub(size(Ie), idx_edges);
	% compute rho for all values of theta (Solutions of line equations with x and y fixed).
	% Do this for all values of x and y.
	rho = x .* cos(val_theta) + y .* sin(val_theta);
	
	% Compute bins for rho.
	bin_rho = round(((rho + max_rho) / (2 * max_rho)) * length(val_rho));
	% Make vector of theta bin indices. Repeat for each row of rho bins (all values of x and y).
	bin_theta = repmat(1:bins_theta, size(bin_rho, 1), 1);
	% Get mask of valid bin_rho values (that are not out of bounds).
	valid = bin_rho > 0 & bin_rho <= bins_rho;
	% Set invalid bin_rho values to nan. This will be handled later.
	bin_rho(not(valid)) = nan;
	% Get linear indices for indexing into accumulator matrix for incrementation.
	lin_indices = sub2ind(size(A), bin_rho(:), bin_theta(:));
	% Remove nan values that represent invalid indices.
	lin_indices = lin_indices(~isnan(lin_indices));
	
	% Get unique linear indices for accumulator matrix incrementation.
	unique_lin_indices = unique(lin_indices);
	% Get repetitions of unique indices.
	reps = histc(lin_indices, unique_lin_indices);
	% Increment corresponding cells in accumulator matrix by number of
	% times the index appeared as a bin_theta, bin_rho pair.
	A(unique_lin_indices) = A(unique_lin_indices) + reps;
	
	% Find indices of elements greater than threshold.
	idx_greater = find(A > threshold);
	
	% Sort indices by values in indexed cells.
	[~, perm] = sort(A(idx_greater), 'descend');
	idx_greater = idx_greater(perm);
	
	% Get values of theta and rho that are above the threshold.
	[rho_idx, theta_idx] = ind2sub(size(A), idx_greater);
	out_rho = val_rho(rho_idx);
	out_theta = val_theta(theta_idx);
end