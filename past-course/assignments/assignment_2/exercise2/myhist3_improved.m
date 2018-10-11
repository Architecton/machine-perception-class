function H = myhist3_improved(img, bins)
	% when computing cell indices add a small factor to avoid overflow
	% problems.
	idx = floor(double(img) * bins / ( 255 + 1e-5)) + 1;
	
	% Reshape array so that columns contain the R, G, B indices in the H
	% array.
	idx2 = permute(idx, [3, 2, 1]);
	idx2 = reshape(idx2, [3, size(idx2, 2) * size(idx2, 3)]);
	
	% Find unique RGB triples and indices at which they occur in the original index matrix.
	[RGB_unique, ~, ix] = unique(idx2', 'rows');
	
	% Use accumarray with val = 1 to count the number of identical subscripts in subs.
	num_occurences = accumarray(ix, 1);
	
	% Allocate empty matrix for storing the frequencies of values in bins.
	H = zeros(bins, bins, bins);
	
	% Go over unique H matrix indices and set them to number of observed
	% occurences of these indices in the original matrix of indices.
	for k = 1:size(RGB_unique, 1)
		% Compute linear index.
		lin_index = sub2ind(size(H), RGB_unique(k, 1), RGB_unique(k, 2), RGB_unique(k, 3));
		H(lin_index) = H(lin_index) + num_occurences(k);
	end
	
	% Normalize the histogram (sum of cell values should equal to 1).
	H = H / sum(sum(sum(H)));
end