% function pyramid_layers = gauss_pyramid(I, num_layers)
%
% Compute num_layers number of gaussian pyramid layers of image I and store
% result in cell array pyramid_layers.
function pyramid_layers = gauss_pyramid(I, num_layers)
	pyramid_layers = cell(1, num_layers);  % Allocate cell array.
	pyramid_layers{1} = I;
	g = gauss(2);	 % Get gaussian kernel.
	for l = 2:num_layers
		% Apply gaussian filter
		% I = conv2(g, g, I, 'same');
		I = imfilter(I, g, 'symmetric');
		% Subsample and save result.
		I = I(1:2:end, 1:2:end);
		pyramid_layers{l} = I;
	end
end