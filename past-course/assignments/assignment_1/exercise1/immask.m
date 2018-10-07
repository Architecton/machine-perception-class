% function [R] = immask(I, M)
%
% Apply mask M to rgb image I by setting all pixels covered by 0's in M to
% 0 in the original image I. Return the resulting image.
function [R] = immask(I, M)
	R = I(:,:,1);	% Get channels into separate matrices.
	G = I(:,:,2);
	B = I(:,:,3);
	R(not(M)) = 0;	% Set pixels selected by inverted masking matrix to zero.
	G(not(M)) = 0;
	B(not(M)) = 0;
	R = cat(3, R, G, B); % Concatenate the processed channels along the third dimension.
end

	% Another idea:
	%  A(repmat(not(M), [1, 1, 3])) = 0
	%
	%  This replicates the masking M matrix three times into the third dimension.
	