A = reshape(1:16, 4, 4);

% Go over image in 8x8 grids
for r = 0:7  % Go over rows in grid.
	for c = 0:7  % Go over columns in grid.
		for ridx = r*size(I, 1)/8 + 1 : r*size(I, 1)/8 + size(I, 1)/8
			for cidx = c*size(I, 2)/8 + 1 : c*size(I, 2)/8 + size(I, 2)/8
				A(ridx, cidx)
			end
		end
	end
end