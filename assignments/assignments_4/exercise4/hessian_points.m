function I_hess = hessian_points(I, sigma)
	[Ixx, Iyy, Ixy] = image_derivatives2(I, sigma);
	I_hess = sigma.^4 * (Ixx.*Iyy - Ixy.^2);
end