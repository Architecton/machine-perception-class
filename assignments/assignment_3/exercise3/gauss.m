% function [g, x] = gauss(sigma)
% Compute gaussian kernel over [-3*sigma, 3*sigma]
%
function [g, x] = gauss(sigma)
	x = -round(3.0*sigma):round(3.0*sigma);	% Compute domain.
	g = (1/sqrt(2*pi*sigma)) * exp(-(x.^2/(2*sigma^2))); % Evaluate function.
	g = g / sum(g); % Normalize.
end