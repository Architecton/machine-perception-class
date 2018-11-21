% function [out_rho, out_theta, A] = hough_find_lines_informed(Ie, Idir, bins_rho, bins_theta, threshold)
%
% Use gradient information to reduce search space for the Hough transform.
function [out_rho, out_theta, A] = hough_find_lines_informed(Ie, Idir, bins_rho, bins_theta, threshold)
	max_rho = hypot(size(Ie, 1), size(Ie, 2));
	idx_edges = find(Ie > 1e-5);  % Find indices of nonzero elements in Ie matrix.
	% Compute step in angle.
	%dtheta = pi/bins_theta;
	
	% gradient directions of edge points.
	gradient_angles = Idir(idx_edges);
	val_theta = gradient_angles;
	val_theta(val_theta < -pi/2) = val_theta(val_theta < -pi/2) + pi;   % Handle points in third quadrant.
	idx_snd_q = val_theta > pi/2 & val_theta <= pi;  % Handle angles in second quadrant.
	val_theta(idx_snd_q) = val_theta(idx_snd_q) - pi;  
	
	% Get perpendicular directions (direction of line).
	idx_positive = val_theta > 0;
	idx_negative = val_theta < 0;
	val_theta(idx_positive) = val_theta(idx_positive) - pi/2;
	val_theta(idx_negative) = val_theta(idx_negative) + pi/2;
	
	% Compute subinterval for angle theta.
	%val_theta = cell2mat(arrayfun(@(x) (x-10*dtheta):dtheta:(x+10*dtheta), val_theta, 'UniformOutput', false));
	
	val_rho = linspace(-max_rho, max_rho, bins_rho); % Partition interval [-max_rho, max_rho] into bins_rho bins
	A = zeros(bins_rho, bins_theta);  % Define accumulator matrix.
	
	% Get x and y values from linear indices.
	[x, y] = ind2sub(size(Ie), idx_edges);
	
	% compute rho for all values of theta (Solutions of line equations with x and y fixed).
	% Do this for all values of x and y.
	rho = x .* cos(val_theta) + y .* sin(val_theta);
	
	% Compute bins for rho.
	bin_rho = round(((rho + max_rho) / (2 * max_rho)) * length(val_rho));
	
	% Compute bins for angle theta.
	[~, E] = discretize([-pi/2, pi/2], bins_theta);
	bin_theta = discretize(val_theta(:), E);
	
	% Handle out of bounds parts of theta subintervals.
	bin_rho = bin_rho(:);
	bin_rho(isnan(bin_theta)) = [];
	bin_theta(isnan(bin_theta)) = [];
	
	% Get mask of valid bin_rho values (that are not out of bounds).
	valid = bin_rho > 0 & bin_rho <= bins_rho;
	% Set invalid bin_rho values to nan. This will be handled later.
	bin_rho(not(valid)) = nan;
	% Get linear indices for indexing into accumulator matrix for incrementation.
	lin_indices = sub2ind(size(A), bin_rho(:), bin_theta(:));
	% Remove nan values that are the result of invalid bins.
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
	out_theta = E(theta_idx);
end