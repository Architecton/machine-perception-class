% Parse images
Candy_image = imread('candy.jpg');
Candy_image_gray = rgb2gray(Candy_image);

% Compute threshold using Otsu's method.
thresh = otsu(rgb2gray(Candy_image));

% Get mask and process it using erosion/dilation.
Raw_mask = rgb2gray(Candy_image) > thresh;
SE = strel('disk', 6, 4);
Processed_mask = imerode(Raw_mask, SE);

% Apply mask.
Res = immask(Candy_image, not(Processed_mask));

imagesc(Res); hold on;

% Selection and plot marking demo. %%%
sel = ginput(1)
plot(sel(1), sel(2), 'ro');