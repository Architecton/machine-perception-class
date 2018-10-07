% function [threshold] = otsu(I)
% 
% Compute threshold using otsu's method.
function [threshold] = otsu(I)
	nbins = 256;				% Create bin for each pixel value.
	counts = myhist(I, nbins);	% Count frequencies of each pixel value. 
	p = counts / sum(counts);	% Normalize to get ratios of pixel values.
	sigma = zeros(nbins, 1);	% Create vector representing bins.
	for t = 1 : nbins			% Go over each bin.
		% Class probabilities
		qlow = sum(p(1 : t));		% comulative value of p to t
		qhigh = sum(p(t + 1 : end)); % comulative value of p from t to end
		
		% Otsu shows that minimizing the intra-class variance is the same as maximizing inter-class variance
		mu_L = sum(p(1:t) .* (1:t)) / qlow;		% See Wikipedia for class mean formulas.
		mu_H = sum(p(t + 1 : end) .* (t + 1 : nbins)) ./ qhigh; % probability of value times value (Expected value)
		sigma(t) = qlow * qhigh * (mu_L - mu_H) ^ 2; % inter-class variance
	end
	[~, threshold] = max(sigma(:)); % Get index of maximum element in sigma.
end