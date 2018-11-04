% function res = simple_median(I, W)
% 
% Apply median filter to a 1-D signal. Use window of width W for computing
% the median.
function res = simple_median(I, W)
	% Pad the array at front and at back.
	I_aux = [zeros(1, fix(W/2)), I, zeros(1, fix(W/2))];
	% Apply median filtering.
	for k = 1+fix(W/2):length(I_aux)- fix(W/2)
		I_aux(k) = median(I_aux(k-fix(W/2):k+fix(W/2)));
	end
	% Extract result.
	res = I_aux(fix(W/2)+1:length(I_aux)-fix(W/2));
end