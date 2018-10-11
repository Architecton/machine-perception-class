function H = myhist3(img, bins)
	% when computing cell indices add a small factor to avoid overflow
	% problems.
	idx = floor(double(img) * bins / ( 255 + 1e-5)) + 1;
	H = zeros(bins, bins, bins);
	
	% increment the appropriate cell of the H(R,G,B) for each pixel in the
	% image. (Iterate over matrix).
	for i = 1:size(img, 1)
		for j = 1:size(img, 2)
			R = idx(i, j, 1);	% Increment appropriate values in histogram.
			G = idx(i, j, 2);
			B = idx(i, j, 3);
			H(R, G, B) = H(R, G, B) + 1;
		end
	end
	% Normalize the histogram (sum of cell values should equal to 1).
	H = H / sum(sum(sum(H)));
end