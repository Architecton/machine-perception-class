% function [y, x] = hessian_points_ext(I, sigma, treshold)
%
% Find hessian determinants for all pixels on image and return x and y
% coordinates of those that are larger than all their neighbors and that
% are also larger than specified treshold.
%
function [y, x] = hessian_points_ext(I, sigma, treshold)
	[Ixx, Iyy, Ixy] = image_derivatives2(I, sigma);
	I_hess = sigma.^4 * (Ixx.*Iyy - Ixy.^2);
	
	% Circularly shift matrix to compare values in all possible directions.
	T_N = circshift(I_hess, [1, 0]);
	T_S = circshift(I_hess, [-1, 0]);
	T_W = circshift(I_hess, [0, 1]);
	T_E = circshift(I_hess, [0, -1]);
	T_NE = circshift(I_hess, [1, -1]);
	T_SE = circshift(I_hess, [-1, -1]);
	T_SW = circshift(I_hess, [-1, 1]);
	T_NW = circshift(I_hess, [1, 1]);
	
	% Find points that are greater than their neighbors and that satisfy
	% treshold.
	L = I_hess - T_N > 0 & I_hess - T_S > 0 & I_hess - T_W > 0 & I_hess - ...
		T_E > 0 & I_hess - T_NE > 0 & I_hess - T_SE > 0 & I_hess - T_SW > 0 & ...
		I_hess - T_NW > 0 & I_hess > treshold;
	
	% Find linear indices of such elements and convert to subscript
	% indices.
	lin_indices = find(L);
	[y, x] = ind2sub(size(I), lin_indices);
end