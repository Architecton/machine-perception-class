% Compute matrix of histogram and cell array of file names.
[histograms, files] = load_histogram_database('images', 8);
% List all distance measurement method specifying parameters ofr the
% compare_histogram function.
distance_meas = {'l2', 'chi2', 'hellinger', 'intersect'};
% We are computing distances to the 20. histogram.
reference = histograms(20, :);
distances = zeros([length(distance_meas), size(histograms, 1)]);	% Allocate matrix for storing distances
for idx = 1:size(histograms, 1)			% Go over histograms.
	for meas = 1:length(distance_meas)	% Go over measurement method specifiers.
		distances(meas, idx) = compare_histograms(reference, histograms(idx, :), distance_meas{meas});
	end
end


% Sort distances and get permutation of original indices.
[sorted_distances, perms] = sort(distances, 2);

% Set limit for how many closest images to mark on plot.
LIM = 5;
for meas = 1:length(distance_meas)		% Go over measurement method specifiers.
	figure(meas);						% Create figure for next comparison method.
	subplot(1, 2, 1);
	distances_x = 1:size(histograms, 1);	% x axis represents histogram index.
	distances_y = distances(meas, :);		% y axis represents distance from reference histogram.
	plot(distances_x, distances_y);
	title(distance_meas{meas} + " (not sorted)"); hold on;
	for k = 1: LIM
		plot(perms(meas, k), sorted_distances(meas, k), 'ro'); % Mark 5 closest matches.
	end
	
	% Plot distance comparison results of sorted histograms in a similar
	% fashion.
	subplot(1, 2, 2);
	distances_y = sorted_distances(meas, :);
	plot(distances_x, distances_y);
	title(distance_meas{meas} + " (sorted)"); hold on;
	for k = 1:LIM
		plot(k, sorted_distances(meas, k), 'ro');
	end
	
end