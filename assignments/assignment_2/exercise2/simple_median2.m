function res = simple_median2(I, W)
	padval = fix(W/2); 
	I_aux = padarray(I, [padval, padval], 0, 'both');
	for k = 1+padval:size(I_aux, 1)-padval
		for l = 1+padval:size(I_aux, 2)-padval
			A = I_aux(k-padval:k+padval, l-padval:l+padval);
			I_aux(k, l) = median(A(:));
		end
	end
	res = I_aux(padval+1:size(I_aux, 1)-padval, padval+1:size(I_aux, 2)-padval);
end