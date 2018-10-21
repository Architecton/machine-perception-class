% Exercise 1 - Assignment 1 %

% (a) %%
% Read the image from the file umbrellas.jpg and display it.

A = imread('umbrellas.jpg');	% Read image into matrix A
figure(1); clf; imagesc(A);		% Create new figure, clear it, show image.
figure(2); clf; imshow(A);

% The image consists of three channels (Red, Green and Blue)

% At first glance, there is no substantial difference between the two
% functions used to display the image. We will demonstrate the difference
% between them later on.

% (b) %%

% Convert the color image into a grayscale one by averaging all three
% channels.
input('Press enter to close all figures and continue.'); close all;
Ad = double(A);
[h, w, d] = size(A);
A_gray = uint8(Ad(:,:,1) + Ad(:,:,2) + Ad(:,:,3) / 3.0);  % Change image to unsigned 8-bit.
figure; imshow(A_gray);

% (A similar effect can be achieved by using the built-in rgb2gray function)

% (c) %%

% Cut out a rectangular sub-image and display it as a new image. Mark the
% same region in the original image by settig its thrid (blue) color
% channel to 0 and displaying the modified image.
input('Press enter to close all figures and continue.'); close all;
A1 = A;
A1(130:260, 240:450, 3) = 0;	% Set blue channel in marked region to zero.
figure;
subplot(1, 2, 1);
imshow(A1);
A2 = A(130:260, 240:450, 1);	% Cut out section from image.
subplot(1, 2, 2);
imshow(A2);

% Display a grayscale image that has a region negated (values are inverted)
A3 = A_gray;
A3(130:260, 240:450) = 255 - A3(130:260, 240:450);
figure;
imshow(A3);

% (e) %%%

% Calculate a new image by multiplying the elements of the original image
% with appropriate factor (and then round the result). Choose the
% multiplication factor so that the resulting image will have the highest
% possible grayscale level 63 (the lowest remains 0).

% Explain the difference between imagesc and imshow by observing the
% results of displaying this new image.

% #####
input('Press enter to close all figures and continue.'); close all;
A4 = rgb2gray(A);					% Convert to grayscale image.
A4 = uint8(63/255 .* double(A4));	% Multiply by appropriate multiplication factor

% Plot results
figure; imagesc(A4); colormap gray;
figure; imshow(A4);					% Notice this plot is darker.

% Explanation from MATLAB help:

% imshow is the fundamental display function in MATLAB, optimizing figure,
% axes, and image object property setting for image display whereas imagesc
% does not do any of this.
%
% imagesc scales the data to use the full colormap whereas imshow does not.

% #####