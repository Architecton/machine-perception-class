% function [px, py] = harris_points(I, sigma, thresh)
%
% Compute Harris feature points.
function [px, py, T] = harris_points(I, sigma, thresh)
	[Ix, Iy] = image_derivatives(I, sigma);
	% define gaussian smoothing filter kernel with sigma' = sigma*1.6
	g = gauss(1.6*sigma);
	
	% Set constant alpha to 0.06.
	alpha = 0.06;
	% det(C) − alpha*trace^2(C) > t.
	T = conv2(Ix.^2, g, 'same') .* conv2(Iy.^2, g, 'same') - alpha*(conv2(Ix.^2, g, 'same') + conv2(Iy.^2, g, 'same')).^2;
	
	% Circularly shift matrix to compare values in all possible directions.
	T_N = circshift(T, [1, 0]);
	T_S = circshift(T, [-1, 0]);
	T_W = circshift(T, [0, 1]);
	T_E = circshift(T, [0, -1]);
	T_NE = circshift(T, [1, -1]);
	T_SE = circshift(T, [-1, -1]);
	T_SW = circshift(T, [-1, 1]);
	T_NW = circshift(T, [1, 1]);
	
	% Find points that are greater than their neighbors and that satisfy
	% treshold.
	L = T - T_N > 0 & T - T_S > 0 & T - T_W > 0 & T - ...
		T_E > 0 & T - T_NE > 0 & T - T_SE > 0 & T - T_SW > 0 & ...
		T - T_NW > 0 & T > thresh;
	
	% Find linear indices of such elements and convert to subscript
	% indices.
	lin_indices = find(L);
	[py, px] = ind2sub(size(I), lin_indices);
end