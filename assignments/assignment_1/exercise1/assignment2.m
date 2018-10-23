% (a) Test the tresholding operation with a manually set threshold
A = rgb2gray(imread('bird.jpg'));
M = A > 55;							% Manually set treshold.
figure; imagesc(M); colormap gray;

% (b) Create a script myhist.m and use it to implement function myhist that
% is provided with a 2-D grayscale image and a number of bins, and the
% function returns a 1-D histogram as well as the bottom reference for each
% bin.
input('Press enter to close all figures and continue.'); close all;
% Plot some examples
figure(1); clf;
subplot(1, 2, 1)
[H, bins] = myhist(A, 10);
bar(bins, H)

B = rgb2gray(imread('umbrellas.jpg'));
[H, bins] = myhist(B, 10);
subplot(1, 2, 2)
bar(bins, H)

% Comparing histograms with different number of bins.
figure;
[H1, bins1] = myhist(B, 10);
[H2, bins2] = myhist(B, 20);
[H3, bins3] = myhist(B, 30);
subplot(1, 3, 1); bar(bins1, H1); title('10 bins');
subplot(1, 3, 2); bar(bins2, H2); title('20 bins');
subplot(1, 3, 3); bar(bins3, H3); title('30 bins');

% Notice that by increasing the number of bins there is a greater number of
% intensity values that are individually accounted for.

% (c) Histogram calculation is also imlemented in MATLAB in form of
% function hist. Explain why the shape of the histogram changes with the
% number of bins (See above).
input('Press enter to close all figures and continue.'); close all;
I = double(rgb2gray(imread('umbrellas.jpg')));	% Read image.
P = I(:);						% Alternative way to convert image to vector.
figure(1); clf;					% Select new figure and clear it.
bins = 10;						% Set number of bins.
H = hist(P, bins);				% Compute histogram
subplot(1, 3, 1); bar(H, 'b');	% Create a 1x3 subplot array and plot histograms 
bins = 20;						% with different numbers of bins.
H = hist(P, bins);
subplot(1, 3, 2); bar(H, 'b');
bins = 40;
H = hist(P, bins);
subplot(1, 3, 3); bar(H, 'b');

% (d) Visualize results of myhist and hist for other images of your choice.
% Notice that the results may be a bit different between the two functions.
% Do you know why? Explain.
input('Press enter to close all figures and continue.'); close all;
% Set number of bins
nbins = 10;
% function that plots results of MATLAB hist and myhist side by side.
compare_hist('bird.jpg', nbins);
compare_hist('umbrellas.jpg', nbins);
compare_hist('eagle.jpg', nbins);

% Hist operates on a general sequence of numbers. It chooses the bin
% centers to best visualize the data value frequencies found in the
% sequence and does not constrain the bin centers on the interval that is
% characteristic of images. The MATLAB hist function also returns the
% absolute frequencies of values in each bin.


% (e) (10 points) Test myhist function on images (three or more) of the
% same scene in different lighting conditions. Visualize the histograms for
% all images for different number of bins and interpret the results.
input('Press enter to close all figures and continue.'); close all;
LD_images = {rgb2gray(imread('flask_light.jpg')), rgb2gray(imread('flask_dark.jpg')), rgb2gray(imread('book_light.jpg')), rgb2gray(imread('book_dark.jpg')), rgb2gray(imread('shoes_light.jpg')), rgb2gray(imread('shoes_dark.jpg')), rgb2gray(imread('pencilcase_light.jpg')), rgb2gray(imread('pencilcase_dark.jpg'))};

% Set number of bins
NBINS = 10;

% Visualize results.
for idx = 1:2:length(LD_images)
	figure;
	visualize_ld_pair(LD_images{idx}, LD_images{idx +1}, NBINS);
end


% (f) Using the knowledge about the construction of histograms you can now
% implement a simple automatic thresholding algorithm called Otsu's method
% that works on bi-modal histograms and determines the threshold to best
% separate the two modes or classes in the image.

% Test the automatic thresholding algorithm using the image loaded from
% bird.jpg. Convert the image to grayscale, calculate threshold using otsu
% function and apply the threshold to obtain a mask. Display the mask using
% imagesc.
input('Press enter to close all figures and continue.'); close all;
B = rgb2gray(imread('bird.jpg'));	% Parse image.
Thresh = otsu(B);					% Compute threshold using Otsu's method.
M = B > Thresh;						% Get result of using threshold.
figure; imagesc(M); colormap gray;	% Plot result.