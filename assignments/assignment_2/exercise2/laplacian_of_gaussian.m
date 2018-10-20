% laplacian_of_gaussian:
function res = laplacian_of_gaussian(I1, I2)
	R1 = I1(:,:,1); Rl = simple_laplacian2(R1);
	G1 = I1(:,:,2); Gl = simple_laplacian2(G1);
	B1 = I1(:,:,3); Bl = simple_laplacian2(B1);

	R2 = I2(:,:,1); Rg = imgaussfilt(R2, 3);
	G2 = I2(:,:,2); Gg = imgaussfilt(G2, 3);
	B2 = I2(:,:,3); Bg = imgaussfilt(B2, 3);
	
	R_mean = uint8((double(Rl) + double(Rg))/2);
	G_mean = uint8((double(Gl) + double(Gg))/2);
	B_mean = uint8((double(Bl) + double(Bg))/2);
	res = cat(3, R_mean, G_mean, B_mean);
end