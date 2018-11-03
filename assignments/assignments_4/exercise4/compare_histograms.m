% function [d] = compare_histograms(h1, h2, dist_name)
%
% Compare two histograms with specified distance measure. Valid distance
% measure specifications are 'l2' for euclidean distance, 'chi2' for
% chi-square distance, 'hellinger' for Hellinger distance and 'intersect'
% for intersection distance.
function [d] = compare_histograms(h1, h2, dist_name)
	% Switch of distance name and compute appropriate distance and return
	% it.
	switch dist_name
		case 'l2'
			d = sqrt(sum((h1 - h2).^2));
		case 'chi2'
			d = 1/2 * sum(((h1 - h2).^2)./(h1 + h2 + 1e-10));
		case 'hellinger'
			d = sqrt(1/2 * sum((sqrt(h1) - sqrt(h2)).^2));
		case 'intersect'
			d = 1 - sum(min(h1, h2));
		otherwise
			error('Unknown distance type!');
	end