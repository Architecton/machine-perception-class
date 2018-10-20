function res = simple_laplacian(I)
	I_aux = padarray(I, [1, 1], 0, 'both');
	I_res = zeros(size(I_aux));
	for k = 2:size(I_aux,1)-1
		for l = 2:size(I_aux,2)-1
			r = I_aux(k+1, l) + I_aux(k-1, l) + I_aux(k, l+1) + I_aux(k, l-1) - 4*I_aux(k, l);
			I_res(k, l) = r;
		end
	end
	res = I_res(2:length(I_res)-1, 2:length(I_res)-1);
end