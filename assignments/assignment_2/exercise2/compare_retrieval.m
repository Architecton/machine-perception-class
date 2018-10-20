function [res] = compare_retrieval(histograms, histograms_weighted)
	distance_meas = {'l2', 'chi2', 'hellinger', 'intersect'};
	reference = histograms(20, :);	% Take the 20. histogram as reference.
	reference_weighted = histograms_weighted(20, :);
	% Allocate matrix for storing distances. Each row stores distances for each
	% comparison measure type.
	distances = zeros([length(distance_meas), size(histograms, 1)]);
	distances_weighted = zeros([length(distance_meas), size(histograms_weighted, 1)]);
	% Go over histograms.
	for idx = 1:size(histograms, 1)
		for meas = 1:length(distance_meas)
			distances(meas, idx) = compare_histograms(reference, histograms(idx, :), distance_meas{meas});
			distances_weighted(meas, idx) = compare_histograms(reference_weighted, histograms_weighted(idx, :), distance_meas{meas});
		end
	end

	% Sort distances and get permutation of original indices.
	[distances, perms] = sort(distances, 2);
	[distances_weighted, perms_weighted] = sort(distances_weighted, 2);
	
	% Store distances to first six closest images to reference and their
	% indices - first two rows -> unweighted histograms, second two rows -> weighted
	% histograms
	res = [distances(:, 1:6); perms(:, 1:6); distances_weighted(:, 1:6); perms_weighted(:, 1:6)];
	
end
