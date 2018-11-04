% function res = simple_median2(I, W)
%
% Take image and width of signal and apply median filter.
%
function res = simple_median2(I, W)
	padval = fix(W/2);  % Compute number of pad cells to add.
	I_aux = padarray(I, [padval, padval], 0, 'both');
	for k = 1+padval:size(I_aux, 1)-padval  % Go over original image
		for l = 1+padval:size(I_aux, 2)-padval
			A = I_aux(k-padval:k+padval, l-padval:l+padval);  % Values in windows.
			I_aux(k, l) = median(A(:));  % Compute median.
		end
	end
	% Extract result from padded matrix that is the same size as the
	% original matrix.
	res = I_aux(padval+1:size(I_aux, 1)-padval, padval+1:size(I_aux, 2)-padval);
end