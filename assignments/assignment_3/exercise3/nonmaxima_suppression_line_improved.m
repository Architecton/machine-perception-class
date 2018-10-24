% function Imax = nonmaxima_suppression_line(Imag, Idir)
%
% Implementation of thinning by non-maxima suppresion. Create an image that
% only contains the local maxima of lines present in matrix of gradient
% magnitudes.
function Imax = nonmaxima_suppression_line_improved(Imag, Idir)
	[h, w] = size(Imag);  % Get height and width of image.
	Imax = zeros(h,w);    % Allocate matrix for result image.
	
	% Circularly shift matrix to compare values in all possible directions.
	T_N = circshift(Imag, [1, 0]);
	T_S = circshift(Imag, [-1, 0]);
	T_W = circshift(Imag, [0, 1]);
	T_E = circshift(Imag, [0, -1]);
	T_NE = circshift(Imag, [1, -1]);
	T_SE = circshift(Imag, [-1, -1]);
	T_SW = circshift(Imag, [-1, 1]);
	T_NW = circshift(Imag, [1, 1]);
	
	% Find maximas in each direction. Test if value is positive if
	% subtracting both adjacent elements in stated direction. (Two numbers are both
	% positive, if their product as well as their sum is positive).
	maxima_NS = (Imag - T_N) .* (Imag - T_S) > 0 & (Imag - T_N) + (Imag - T_S) > 0;
	maxima_WE = (Imag - T_W) .* (Imag - T_E) > 0 & (Imag - T_W) + (Imag - T_E) > 0;
	maxima_NWSE = (Imag - T_NW) .* (Imag - T_SE) > 0 & (Imag - T_NW) + (Imag - T_SE) > 0;
	maxima_NESW = (Imag - T_NE) .* (Imag - T_SW) > 0 & (Imag - T_NE) + (Imag - T_SW) > 0;
	
	idx = round(((Idir + pi) ./ pi) .* 4) + 1;  % Get matrix of gradient directions.
	% Values of idx:
	% 
	% 1 - WE
	% 2 - NESW
	% 3 - NS
	% 4 - NWSE
	% 5 - WE
	% 6 - NESW
	% 7 - NS
	% 8 - NWSE
	% 9 - WE
	
	% Find maxima where the maxima are along a gradient direction.
	% Get the indices of the maxima.
	id1 = find(maxima_NS & (idx == 3 | idx == 7));
	id2 = find(maxima_WE & (idx == 1 | idx == 5 | idx == 9));
	id3 = find(maxima_NWSE & (idx == 2 | idx == 6));
	id4 = find(maxima_NESW & (idx == 4 | idx == 8));
	
	% Add gradient magnitude values at appropriate indices to results
	% matrix.
	Imax(id1) = Imag(id1);
	Imax(id2) = Imag(id2);
	Imax(id3) = Imag(id3);
	Imax(id4) = Imag(id4);
	
end