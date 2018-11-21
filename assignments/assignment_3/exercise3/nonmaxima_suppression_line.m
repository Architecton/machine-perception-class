% function Imax = nonmaxima_suppression_line(Imag, Idir)
%
% Implementation of thinning by non-maxima suppresion. Create an image that
% only contains the local maxima of lines present in matrix of gradient
% magnitudes.
function Imax = nonmaxima_suppression_line(Imag, Idir)
	[h, w] = size(Imag);  % Get height and width of image.
	Imax = zeros(h,w);    % Allocate matrix for result image.
	% Comparison direction lookup table
	offx = [-1 -1 0 1 1 1 0 -1 -1];
	offy = [ 0 -1 -1 -1 0 1 1 1 0];
	for y = 1:h			  % Go over pixels in image.
		for x = 1:w
			dir = Idir(y, x); % Get direction of gradient.
			idx = round(((dir + pi) / pi) * 4) + 1;  % Map orientation to the lookup table.
			y1 = y + offy(idx) ; x1 = x + offx(idx); % Apply offset corresponding to gradient orientation.
			y2 = y - offy(idx) ; x2 = x - offx(idx); % Go in both directions.
			x1 = max([1, x1]); x1 = min([w, x1]);    % Make sure that offset pixels are still on image.
			y1 = max([1, y1]); y1 = min([h, y1]);
			x2 = max([1, x2]); x2 = min([w, x2]);
			y2 = max([1, y2]); y2 = min([h, y2]);
			% Check if point is local maximum (check if the value of the pixel
			% is larger than the value of pixels at offset locations.)
			if((Imag(y, x) >= Imag(y1, x1))&&(Imag(y, x) >= Imag(y2, x2)))
				Imax(y, x) = Imag(y, x);  % Add to gradient magnitude value to resulting image.
			end
		end
	end
end