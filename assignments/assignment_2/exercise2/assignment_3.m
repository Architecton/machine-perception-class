% (a) %% 
% Write a function gaussfilter.m, that generates a Gaussian filter and applies it to
% a 2D image taking into account that the kernel is separable. Instead of the conv
% function use its analogy in 2D space, conv2. Generate a 1D kernel and use it to filter
% the image in the first dimension (Ib = conv2(I, g, 'same')) and then in the second
% dimension simply by transposing the kernel (Ig = conv2(Ib, g' ,'same')). Test
% the function by using the code snippet below that loads a reference image lena.png,
% transforms it to grayscale and corrupts it with a Gaussian noise (pixel value offset
% by a random number, sampled from a Gaussian distribution), as well as the salt-
% and-pepper noise (a portion of randomly selected pixels set to the lowest, black, or
% highest, white, value). Then the code uses the gaussfilter function (with sigma = 1 )
% to filter both corrupted images.

% see gaussfilter.m

% Testing the written function:
A = rgb2gray(imread('lena.png'));
Icg = imnoise(A,'gaussian', 0, 0.01); % Gaussian noise
figure;
subplot(2,2,1); imshow(Icg); colormap gray;
axis equal; axis tight; title('Gaussian noise');
Ics = imnoise(A,'salt & pepper', 0.1); % Salt & pepper noise
subplot(2,2,2) ; imshow(uint8(Ics)); colormap gray;
axis equal; axis tight; title('Salt and pepper');
Icg_b = gaussfilter(double(Icg), 1);
Ics_b = gaussfilter(double(Ics), 1);
subplot(2,2,3) ; imshow(uint8(Icg_b)); colormap gray;
axis equal; axis tight; title('Filtered') ;
subplot(2,2,4) ; imshow(uint8(Ics_b)); colormap gray;
axis equal; axis tight; title('Filtered');

% Question: Which noise is better removed using the Gaussian filter?

% Gaussian noise is better removed by the Gaussian filter.

% (b) %%
% Another useful filter that you have heard about at the lectures is sharpening filter.
%
% Look for its formulation in the slides, implement it and test it on image museum.jpg .
% What do you notice?

% See sharpening_filter.m
input('Press enter to close all figures and continue.'); close all;
M = rgb2gray(imread('museum.jpg'));
Is = sharpening_filter(M);
figure; subplot(1, 2, 1); imagesc(M); colormap gray; title('Original')
subplot(1, 2, 2); imagesc(Is); colormap gray; title('Filtered with sharpening filter')

% The sharpening filter enhances differences by local averaging.
%
% The sharpening filter is a high-pass filter that passes signals that are
% higher than a cutoff frequency.
%
% This can be a problem when dealing with images with a lot of noise. 
% While low-pass filtering smooths out noise, 
% high-pass filtering does just the opposite: it amplifies noise.

% (c) %%
% Implement a nonlinear median filter that has also been mentioned at the lectures. In
% comparison Gaussian filter computes a locally weighted average values to compute
% a weighted mean of the signal, the median lter sorts the signal values in the given
% filter window and uses the middle value of the sorted sequence (a median) as a local
% result. Implement a simple median lter as a function simple_median , that takes
% an input signal I and a width of the ler W as an input and returns a ltered signal.

% Use the snippet below to test the function. It generates a 1 D step signal and corrupts
% it using the salt-and-pepper noise and then lters it using the Gaussian and median
% filter that you have implemented. Set the parameters of the lters that they would
% achieve the best reconstruction result.

% see simple_median.m

input('Press enter to close all figures and continue.'); close all;
% Testing the implementation - code from instructions:
x = [zeros(1, 14), ones(1, 11), zeros(1, 15)]; % Input signal
xc = x; xc(11) = 5; xc(18) = 5; % Corrupted signal
figure;
subplot(1, 4, 1); plot(x); axis([1, 40, 0, 7]); title('Input');
subplot(1, 4, 2); plot(xc); axis([1, 40, 0, 7]); title('Corrupted');
g = gauss(1);
x_g = conv(xc, g, 'same');
x_m = simple_median(xc, 5);
subplot(1, 4, 3); plot(x_g); axis([1, 40, 0, 7]); title('Gauss');
subplot(1, 4, 4); plot(x_m); axis([1, 40, 0, 7]); title('Median');

% Question: Which filter performs better at this specic task? In comparison to
% Gaussian filter that can be applied multiple times in any order, does the order
% matter in case of median filter? What is the name of filters like this?

% The results of the median filter are closer to the input signal. Since
% the median filter is a non-linear filter, the order matters.


% (d) %%
% Implement a 2 -D version of the median filter and test it on an im-
% age, corrupted by a Gaussian noise as well as the salt-and-pepper noise. Compare
% the results with the Gaussian lter for multiple noise intensities as well as lter
% sizes. Compare (analytically estimate) what is the computation complexity of the
% Gaussian filter operation and what is the computational complexity of the median
%filter using the O(·) notation. (in the median filter we use the quicksort algorithm to
% perform sorting.

input('Press enter to close all figures and continue.'); close all;
% See simple_median2 for implementation.
% Testing the implementation:
L = rgb2gray(imread('lena.png'));	% Parse image.
Lns = imnoise(L,'salt & pepper');	% Add noise.
Lng = imnoise(L,'gaussian');
figure;								% Display results of filtering.
subplot(2, 3, 1); imshow(Lng); title('Gaussian noise');
subplot(2, 3, 2); imshow(imgaussfilt(Lng, 2)); title('Gauss Filtered');
subplot(2, 3, 3); imshow(simple_median2(Lng, 3)); title('Median Filtered');

subplot(2, 3, 4); imshow(Lns); title('Salt and pepper');
subplot(2, 3, 5); imshow(imgaussfilt(Lns, 2)); title('Gauss Filtered');
subplot(2, 3, 6); imshow(simple_median2(Lns, 3)); title('Median Filtered');

% (e) %%
% Implement the hybrid image approach that was presented at lectures.
% To do this you also have to implement the Laplacian filter, filter two images (one
% with Gaussian and one with Laplacian filter) and combine them together. You can
% use images cat1.jpg and cat2.jpg as a reference since they are both of the same
% size. Do not convert them to grayscale, simply apply the same operations to all three
% channels and display the result as a color image.

input('Press enter to close all figures and continue.'); close all;
% Parse cat pictures.
C1 = imread('cat1.jpg');
C2 = imread('cat2.jpg');
% Compute laplacian of gaussian and visualize results.
res = hybridize(C1, C2);
imshow(res)