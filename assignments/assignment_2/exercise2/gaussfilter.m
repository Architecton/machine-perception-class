function Ig = gaussfilter(I, sigma)
	g = gauss(sigma);
	Ig = conv2(g, g, I, 'same');
	
	% Is same as:
	% Ib = conv2(I, g 'same');
	% Ig = conv2(Ib, g', 'same');
end