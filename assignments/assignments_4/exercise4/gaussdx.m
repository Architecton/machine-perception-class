% function k = gaussdx(sigma)
%
% Compute kernel representing the convolution of the gaussian kernel and
% the derivation kernel. The parameter sigma specifies the standard
% deviation used in the construction of the gaussian kernel.
function k = gaussdx(sigma)
	g = gauss(sigma);  % Get gaussian kernel.
	der_ker = [1 -1];  % Define derivation kernel. (Will be rotated by MATLAB's conv function)
	k = conv(g, der_ker); % der_ker * g
	k = k ./ sum(abs(k)); % Normalize - sum of abs values is 1.
end