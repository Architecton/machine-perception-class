% (a) Experiment with the sequences of the dilate and erode operations

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
Res = immask(imread('bird.jpg'), M_processed);
figure; imagesc(Res);


% (d) Now create a mask from the image in file eagle.jpg and visualize the
% result with immask. Describe the cause of the inverted mask in this case.
% Propose a change to the code that will result in a mask that will show
% the object and not the background.

E = rgb2gray(imread('eagle.jpg'));	% Parse image.
E_rgb = imread('eagle.jpg');
Thresh = otsu(E);					% Determine threshold.
M = E > Thresh;						% Get raw mask.
SE = ones(10, 10);					% Construct structuring elements.
M_processed = imdilate(imerode(M, SE), SE);	% Apply processing with erode and dilate.
Res = immask(E_rgb, M_processed);			% Call immask.
figure; imagesc(Res);						% Plot results.

% To show the object in this case, we would simply negate the mask as such:
Res = immask(E_rgb, not(M_processed));
figure; imagesc(Res)