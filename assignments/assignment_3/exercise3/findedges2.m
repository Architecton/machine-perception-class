function [Ie] = findedges2(I, sigma)
	[Imag, Idir] = gradient_magnitude(I, sigma);
	Ie = nonmaxima_suppression_line(Imag, Idir);
end