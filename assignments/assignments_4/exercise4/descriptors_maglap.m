% function D = descriptors_maglap(I, px, py, m, sigma, bins)
%
% Compute histrogram of magnitude of partial image derivatives and
% laplacian of a gaussian around eah point defined in vectors px and py.
function D = descriptors_maglap(I, px, py, m, sigma, bins)
	rad = round((m - 1) / 2); % Get radius at which to compute the laplacian of gaussian and gradient magnitudes.
	[h, w] = size(I);  % Get size of image.
	D = zeros(length(px), bins ^ 2);  % Allocate matrix for histogram.
	[Imag, Ilap] = features_maglap(I, sigma, bins);  % Compute image magnitude and laplacian of gaussian.
	parfor i = 1 : length(px)  % Go over values in px and py.
		minx = max([px(i) - rad, 1]); % Compute bounds.
		maxx = min([px(i) + rad, w]);
		miny = max([py(i) - rad, 1]);
		maxy = min([py(i) + rad, h]);
		Rmag = Imag(miny:maxy, minx:maxx);  % Get magnitudes.
		Rlap = Ilap(miny:maxy, minx:maxx);  % Get values of laplacian of gaussian.
		
		% Put values in Rmag and Rlap into bins. The histogram has a size
		% of bins x bins.
		d = accumarray(cat(2, Rmag(:), Rlap(:)), 1, [bins, bins]);  
		D(i,:) = d(:) / sum(d(:)); % Compute i-th histogram (histograms are represented as rows in D)
	end
end