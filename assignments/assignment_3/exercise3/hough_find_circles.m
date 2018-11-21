% function [out_a, out_b, A] = hough_find_circles(Ie, bins_a, bins_b, threshold, r)
% 
% Find centres of circles with known radius using the Hough transform.
function [out_a, out_b, A] = hough_find_circles(Ie, bins_a, bins_b, threshold, r)
	
	% hough transform for circles with known radius:
	%
	% If the radius is fixed, then the parameter space would be reduced to 2D 
	% (the position of the circle center). For each point (x, y) on the original circle, 
	% it can define a circle centered at (x, y) with radius R according to (1). 
	% The intersection point of all such circles in the parameter space would be corresponding 
	% to the center point of the original circle.
	
	idx_edges = find(Ie > 1e-2);  % Find indices of nonzero elements in Ie matrix.
	val_a = linspace(0, size(Ie, 1), bins_a); % Get values of a.
	val_b = linspace(0, size(Ie, 2), bins_b); % Get values of b.
	A = zeros(bins_a, bins_b);  % Define accumulator matrix.
	
	% Get x and y values from linear indices.
	[x, y] = ind2sub(size(Ie), idx_edges);
	
	% Compute values of parameter a.
	% Do this for all values of x and y.
	a = x - r .* cos(linspace(0, 2*pi, bins_a));
	b = y - r .* sin(linspace(0, 2*pi, bins_a));
	
	% Compute bins for a.
	bin_a = discretize(a, val_a);
	% Compute bins for b.
	bin_b = discretize(b, val_b);
	% Get mask of valid a and b values.
	valid_a = bin_a > 0 & bin_a <= bins_a;
	valid_b = bin_b > 0 & bin_b <= bins_b;
	% Set invalid bin_rho values to nan. This will be handled later.
	bin_a(not(valid_a)) = nan;
	bin_b(not(valid_b)) = nan;
	% Get linear indices for indexing into accumulator matrix for incrementation.
	lin_indices = sub2ind(size(A), bin_a', bin_b')';
	% Get unique linear indices for accumulator matrix incrementation.
	for k = 1:size(lin_indices, 1)
		lin_indices_nxt = lin_indices(k, :);
		lin_indices_nxt = lin_indices_nxt(~isnan(lin_indices_nxt));
		unique_lin_indices = unique(lin_indices_nxt);
		% Get repetitions of unique indices.
		reps = histc(lin_indices_nxt, unique_lin_indices);
		% Increment corresponding cells in accumulator matrix by number of
		% times the index appeared.
		A(unique_lin_indices) = A(unique_lin_indices) + reps;
	end
	
	% Find indices of elements greater than threshold.
	idx_greater = find(A > threshold);
	
	% Sort indices by values in indexed cells.
	[~, perm] = sort(A(idx_greater), 'descend');
	idx_greater = idx_greater(perm);
	
	% Get values of a and b that are above the threshold.
	[a_idx, b_idx] = ind2sub(size(A), idx_greater);
	out_a = val_a(a_idx);
	out_b = val_b(b_idx);
end