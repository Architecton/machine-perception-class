% Parse images
Candy_image = imread('candy.jpg');
Candy_image_gray = rgb2gray(Candy_image);

% Adjust image contrast for better tresholding.
Candy_image_gray = imadjust(Candy_image_gray, [0.78, 0.92],[]);
	
% Compute threshold using Otsu's method.
thresh = otsu(Candy_image_gray);

% Get mask and process it using erosion/dilation.
Raw_mask = Candy_image_gray > thresh;
SE = strel('disk', 11);
Processed_mask = imclose(Raw_mask, SE);

% Apply mask.
Res = immask(Candy_image, not(Processed_mask));

% Plot image.
imshow(Candy_image); hold on;

% Selection and plot marking demo. %%%
sel = ginput(1)

% If selected point which is on candy (Mask value at indices is 0)
if Processed_mask(floor(sel(2)), floor(sel(1))) == 0
	
	% Get connected regions.
	[Labeled_mask, num_regions] = bwlabel(not(gpuArray(Processed_mask)));
	
	% Compute average colors of connected regions. %%
	
	% vector used to store the average colors of the regions.
	regions_avg = zeros([3, num_regions]); 
	for region_index = 1:num_regions
		% Find row and column coordinates of next region.
		[row_coordinates, column_coordinates] = find(Labeled_mask == region_index);
		% Find indices of region.
		idx = sub2ind(size(Processed_mask), row_coordinates, column_coordinates);
		
		% Average the colors in the found pixels and save to recording
		% vector.
		
		% Extract color channels.
		R = Candy_image(:,:,1);
		G = Candy_image(:,:,2);
		B = Candy_image(:,:,3);
		
		% Extract region with index region_index on each channel.
		R_region = R(idx);
		G_region = G(idx);
		B_region = B(idx);
		
		% Concatenate average values on each channel into a vector.
		col3 = [mean(R_region); mean(G_region); mean(B_region)];
		
		% Save average color vector for this region.
		regions_avg(:, region_index) = col3;
		
	end
	
	% Get region centroids.
	s = regionprops(Labeled_mask, 'centroid');
	
	% Find region of selected point and get average color of selected region.
	sel_region = Labeled_mask(floor(sel(2)), floor(sel(1)));
	sel_col = regions_avg(:, sel_region);
	
	% Find regions which are of similar color (use threshold)
	tresh = 42.402;
	sim_counter = 0;	% Count regions that are similar up to a threshold.
	for region_index = 1:num_regions
		if norm(sel_col - regions_avg(:, region_index)) < tresh
			sim_counter = sim_counter + 1;
			% Mark centroid of region.
			plot(s(region_index).Centroid(1), s(region_index).Centroid(2), 'ro');
		end
	end
	% Print number of regions with similar color.
	text(20, 25, 'Count: ' + string(sim_counter));
else
	text(20, 25, 'Selected point is not on a candy.');
end