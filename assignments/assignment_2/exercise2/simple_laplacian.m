% function res = simple_laplacian(I)
%
% Compute laplacian operator numerically for each pixel.
function res = simple_laplacian(I)
	% Pad matrix with zeros.
	I_aux = padarray(I, [1, 1], 0, 'both');
	% Allocate matrix for results.
	I_res = zeros(size(I_aux));
	% Go over matrix and compute results using numerical operators.
	for k = 2:size(I_aux,1)-1
		for l = 2:size(I_aux,2)-1
			r = I_aux(k+1, l) + I_aux(k-1, l) + I_aux(k, l+1) + I_aux(k, l-1) - 4*I_aux(k, l);
			I_res(k, l) = r;
		end
	end
	% Trim to same size.
	res = I_res(2:length(I_res)-1, 2:length(I_res)-1);
end