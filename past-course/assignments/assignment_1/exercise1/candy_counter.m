% Parse images
Candy_image = imread('candy.jpg');
Candy_image_gray = rgb2gray(Candy_image);

Candy_image_gray = imadjust(Candy_image_gray, [0.85, 0.92],[]);
imagesc(Candy_image_gray); colormap gray;

% Compute threshold using Otsu's method.
thresh = otsu(Candy_image_gray);

% Get mask and process it using erosion/dilation.
Raw_mask = Candy_image_gray > thresh;
SE = strel('disk', 11);
Processed_mask = imclose(Raw_mask, SE);

% Apply mask.
Res = immask(Candy_image, not(Processed_mask));

imagesc(Res); hold on;

% Selection and plot marking demo. %%%
sel = ginput(1)

% If selected point which is on candy (Mask value at indices is 0)
if Processed_mask(floor(sel(2)), floor(sel(1))) == 0
	% Get connected regions.
	
	% Compute average colors of connected regions.
	
	% Find region of selected point.
	
	% Find regions which are of same color (use threshold)
	
	% Mark centers of regions with same color.
else
	disp('false')
end

plot(sel(1), sel(2), 'ro');