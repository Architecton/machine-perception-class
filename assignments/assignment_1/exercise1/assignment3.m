% (a) Experiment with the sequences of the dilate and erode operationsL = bwlabel(M);		% Label mask.

M = logical(imread('mask.png'));	% Parse image.
SE = ones(3);		% Construct structuring element.
figure; imagesc(M); % Plot original image.
title('Original');

% Plot various chaining of the dilate and erode operations.
figure;
subplot(1, 4, 1);
imagesc(imerode(M, SE)); axis equal; axis tight; title('Erode');
subplot(1, 4, 2);
imagesc(imdilate(M, SE)); axis equal; axis tight; title('Dilate');
subplot(1, 4, 3);
imagesc(imerode(imdilate(M, SE), SE)); axis equal; axis tight; title('Dilate & Erode');
subplot(1, 4, 4);
imagesc(imdilate(imerode(M, SE), SE)); axis equal; axis tight; title('Erode & Dilate');

% (b) Implement a closing operation which is composed of two elementary
% operations: dilate and erode that use the same kernel. Test application
% of different structuring elements (different sizes) to obtain a clean
% mask.
input('Press enter to close all figures and continue.'); close all;
A = rgb2gray(imread('bird.jpg'));	% Parse image.
Thresh = otsu(A);					% Compute threshold using Otsu's method.
M = A > Thresh;						% Get raw mask.
SE = ones(15, 15);					% Process mask using dilate and erode operations.
M_processed = imerode(imdilate(M, SE), SE);
figure; imagesc(M_processed); colormap gray; % Display resulting processed mask.

% (c) Create a script file immask.m and use it to implement function immask
% that can be given a three channel color image and a binary image of the
% same size and returns an image hwere pixel values are set to black color
% if their corresponding pixel in the binary image is 0. The function has
% to be written without explicit loops in the syntax. Hint: working with
% single channel images is easier than working with all channels at once.
% You can then use function cat to combine them back together into a color
% image. Write a script that tests the result of the previous task:
% creating a mask using automatic thresholding, cleaning it up using
% morphological operations, and displaying a masked input color image.

% Note: M_processed was constructed in the previous task.
input('Press enter to close all figures and continue.'); close all;
Res = immask(imread('bird.jpg'), M_processed);
figure; imagesc(Res);


% (d) Now create a mask from the image in file eagle.jpg and visualize the
% result with immask. Describe the cause of the inverted mask in this case.
% Propose a change to the code that will result in a mask that will show
% the object and not the background.
input('Press enter to close all figures and continue.'); close all;
E = rgb2gray(imread('eagle.jpg'));	% Parse image.
E_rgb = imread('eagle.jpg');
Thresh = otsu(E);					% Determine threshold.
M = E > Thresh;						% Get raw mask.
SE = ones(10, 10);					% Construct structuring elements.
M_processed = imdilate(imerode(M, SE), SE);	% Apply processing with erode and dilate.
Res = immask(E_rgb, M_processed);			% Call immask.
figure; imagesc(Res);						% Plot results.

% In this case, the mask masks the object and not the background. This is
% because the object (eagle) is darker than the background (sky).

% To show the object in this case, we would simply negate the mask as such:
Res = immask(E_rgb, not(M_processed));
figure; imagesc(Res)

% % (e) %%Another way to process a mask is to extract individual connected components. Ex-
% periment with function bwlabel that returns a matrix with individual components
% of the mask marked with individual numbers. Write a script that loads image from
% file coins.jpg , obtains a mask, cleaning it up using morphological operations. Then
% use bwlabel to obtain the matrix of connected components and only keep compo-
% nents that contain not more than 700 pixels.
input('Press enter to close all figures and continue.'); close all;
I = imread('coins.jpg'); % Load a synthetic mask
% Compute mask M.
I_gray = rgb2gray(I);
M = not(I_gray > otsu(I_gray));		% Apply tresholding.
M = imclose(M, strel('disk', 12));	% Perform closing morphological operation with circular structuring element.


L = bwlabel(M);  % Use connected components algorithm to label all components.
label_max = max(L(:));  % A trick to get all values present in matrix L
for i = 1:label_max
	if sum(L(:) == i) > 700  % Only process labels that have more than 700 pixels
		L(L == i) = 0;		 % Set labeled pixels to zero.
	end
end
subplot(1, 2, 1);
imshow(I); title('Original');
subplot(1, 2, 2);
imshow(immask(I, L > 0)); title('Processed');  % Mask off the regions with more than 700 pixels.
colormap gray;

% Experiment with the script to see how to isolate or remove a single component.
% Could you also achieve this kind of eect using morphological operations? Discuss
% which kind of sequence of erode and dilate together with per-pixel logical operations
% could you use.
input('Press enter to close all figures and go over last assignment task.'); % Wait for user before going to next task.
close all;
L = bwlabel(M);		% Label mask.
figure; imshow(I);  % Let user select region on image.
sel = ceil(ginput(1));
region_index = L(sel(2), sel(1)); % Get index of region selected by user.
if region_index ~= 0			  % If region on coin, mask off everything else.
	L(L ~= region_index) = 0;
	imshow(immask(I, L));
end

input('Press enter to close all figures and continue.'); % Wait for user before continuing.
% We could use morphological operations to remove the smaller coins.
M_processed = imopen(M, strel('disk', 13)); % Perform opening operation with a circular structuring element.
figure; imshow(immask(I, M_processed));

% (f) %% See candy_counter.m for solution.