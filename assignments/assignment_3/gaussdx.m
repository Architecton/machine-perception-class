function h = gaussdx(sigma)
	g = gauss(sigma);
	der_ker = [0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0];
	h = conv(g, der_ker);
end