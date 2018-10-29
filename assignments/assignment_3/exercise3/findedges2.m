% function [Ie] = findedges2(I, sigma)
%
% Find edges by applying nonmaxima suppresion to gradient map.
%
function [Ie] = findedges2(I, sigma)
	% Get gradient map.
	[Imag, Idir] = gradient_magnitude(I, sigma);
	% Get results of nonmaxima suppresion on gradient map.
	Ie = nonmaxima_suppression_line(Imag, Idir);
end