% function [indices, distances] = find_correspondences(D1, D2)
%
% For each descriptor in D1 find the most similar descriptor in D2 and
% store the mapping in indices. Compute distances to be the similarity
% score for the matches.
function [indices, distances] = find_correspondences(D1, D2)
	% Allocate array for indices.
	indices = zeros(size(D1, 1), 1);
	distances = zeros(size(D1, 1), 1);
	
	% For each descriptor in D1 find closest descriptor in D2.
	parfor d1 = 1:size(D1, 1)
		min_dist = 1e9;
		idx_min_dist = 0;
		for d2 = 1:size(D2, 1)
			% Compare histograms.
			dist = compare_histograms(D1(d1, :), D2(d2, :), 'hellinger');
			if dist < min_dist
				min_dist = dist;
				idx_min_dist = d2;
			end
		end
		% Add found correspondence and distance to result vectors.
		indices(d1) = idx_min_dist;
		distances(d1) = min_dist;
	end
end