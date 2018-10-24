function [Ie] = findedges(I, sigma, theta)
	Imag = gradient_magnitude(I, sigma);
	Ie = Imag > theta;
end