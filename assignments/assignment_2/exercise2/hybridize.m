% function res = hybridize(I1, I2)
%
% Compute and return hybrid image composed of images I1 and I2.
function res = hybridize(I1, I2)
	% Apply laplacian operator to all color channels in first image.
	R1 = I1(:,:,1); Rl = simple_laplacian2(R1);
	G1 = I1(:,:,2); Gl = simple_laplacian2(G1);
	B1 = I1(:,:,3); Bl = simple_laplacian2(B1);

	% Apply gaussian filter to all color channels in second image.
	R2 = I2(:,:,1); Rg = imgaussfilt(R2, 3);
	G2 = I2(:,:,2); Gg = imgaussfilt(G2, 3);
	B2 = I2(:,:,3); Bg = imgaussfilt(B2, 3);
	
	% Combine the two results into single image.
	R_mean = uint8((double(Rl) + double(Rg))/2);
	G_mean = uint8((double(Gl) + double(Gg))/2);
	B_mean = uint8((double(Bl) + double(Bg))/2);
	res = cat(3, R_mean, G_mean, B_mean);
end