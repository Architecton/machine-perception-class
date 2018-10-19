% function Ig = simple_convolution(I, g)
%
% Compute convolution of function I with kernel g and evaluate over
% [N+1, |I| - N]. The values outside this interval are set to zero.
function Ig = simple_convolution(I, g) % I is the signal, g is the kernel.
	N = (length(g) - 1) / 2;		% Kernel is of length 2*N + 1
	Ig = zeros(1, length(I));		% Allocate vector for convolution results.
	for i = N+1:length(I)-N			% Start at N+1 and end at |I|-N.
		i_left = max([1, i - N]);	% Starting position for integration. (lower limit is 1)
		i_right = min([length(I), i + N]); % End position for integration. (upper limit is |I|)
		Ig(i) = sum(g .* I(i_left:i_right)); % Integrate product of functions. Note that dx (index) is 1.
	end
end