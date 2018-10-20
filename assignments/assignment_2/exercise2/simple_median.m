function res = simple_median(I, W)
	I_aux = [zeros(1, fix(W/2)), I, zeros(1, fix(W/2))];
	for k = 1+fix(W/2):length(I_aux)- fix(W/2)
		I_aux(k) = median(I_aux(k-fix(W/2):k+fix(W/2)));
	end
	res = I_aux(fix(W/2)+1:length(I_aux)-fix(W/2));
end