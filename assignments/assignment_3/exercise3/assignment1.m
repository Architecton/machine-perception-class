% (b) Implement a function that computes a derivative of a 1 D Gaussian kernel.

% See gaussdx.m

% The properties of the filter can be analyzed using a impulse response function for
% f(x, y), that is defined as a convolution of a Dirac function with the kernel
% f(x, y). A discrete version of the Dirac function is constructed as a
% finite image that has all but the central element set to 0, while the center element
% contains a non-zero (possibly very high) value:
%
% See https://en.wikipedia.org/wiki/Dirac_delta_function for more
% information.
impulse = zeros(25,25); impulse(13,13) = 255;

% Generate two kernels
sigma = 6.0;
G = gauss(sigma);
D = gaussdx(sigma);

% What happens if you apply the following operations to the image impulse ?:

figure; subplot(2, 3, 1); imagesc(impulse); title('Impulse'); colormap gray;
% (i) First convolution with G and then convolution with G'.
subplot(2, 3, 4); imagesc(conv2(conv2(impulse, G), G')); title('G,Gt');
% (ii) First convolution with G and then convolution with D'.
subplot(2, 3, 2); imagesc(conv2(conv2(impulse, G), D')); title('G,Dt');
% (iii) First convolution with D and then convolution with G'.
subplot(2, 3, 3); imagesc(conv2(conv2(impulse, D), G')); title('D,Gt');
% (iv) First convolution with G' and then convolution with D.
subplot(2, 3, 5); imagesc(conv2(conv2(impulse, G'), D)); title('Gt,D');
% (v) First convolution with D' and then convolution with G.
subplot(2, 3, 6); imagesc(conv2(conv2(impulse, D'), G)); title('Dt,G');

% The order of operations is not important. This is a fundamental property
% of the convolution operator.

% (c) Implement a function that uses functions gauss and gaussdx to compute both
% partial derivatives of a given image, with respect po x and with respect to y.
input('Press enter to close all figures and continue.'); close all;
I = rgb2gray(imread('museum.jpg'));	 % Parse image.

% Implement function gradient_magnitude that accepts a grayscale input image I ,
% and returns a matrix of derivative magnitudes Imag
% p and a matrix of derivative angles
% Idir .

SIGMA = 2;
[Ix, Iy] = image_derivatives(I, SIGMA);	 % Compute image derivatives.
[Ixx, Iyy, Ixy] = image_derivatives2(I, SIGMA);	 % Compute image derivatives.
[Imag, Idir] = gradient_magnitude(I, SIGMA);

% Plot results
figure; subplot(2, 4, 1); imagesc(I); title('Original'); colormap gray;
subplot(2, 4, 2); imagesc(Ix); title('Ix');
subplot(2, 4, 3); imagesc(Iy); title('Iy');
subplot(2, 4, 4); imagesc(Imag); title('Imag');
subplot(2, 4, 5); imagesc(Ixx); title('Ixx');
subplot(2, 4, 6); imagesc(Ixy); title('Ixy');
subplot(2, 4, 7); imagesc(Iyy); title('Iyy');
subplot(2, 4, 8); imagesc(Idir); title('Idir');

input('Press enter to close all figures and continue.'); close all;

% (d) %
% Implement a function gauss_pyramid that receives an image and the number of
% pyramid levels as an input and returns the pyramid layers in a cell array

NUM_LAYERS = 6;
pyramid_layers = gauss_pyramid(rgb2gray(imread('lena.png')), NUM_LAYERS);
figure; colormap gray;
for l = 1:NUM_LAYERS
	subplot(1, NUM_LAYERS, l);
	imagesc(pyramid_layers{l}); title('Layer ' + string(l))
end

% (e) %

% Gradient information is often used in image recognition. Extend your
% image retrieval from the previous exercise to use a simple gradient-based feature
% instead of color histograms. To obtain this feature, compute gradient magnitudes
% and angles, then divide the image in a 8×8 grid and for each cell of the grid compute
% a 8 bin histogram of gradient magnitudes with respect to gradient angles (quantize
% the angles into 8 values and for each pixel in the cell add the value of the gradient
% magnitude to the bin that is specied by the corresponding angle). Combine all
% the histograms to get a feature. Hint: you can also use integrated functions like
% accumarray to speed up feature calculation. Test the new feature on the image
% database that you have received in the previous exercise and compare it to the color
% histogram based retrieval.
input('Press enter to close all figures and continue.'); close all;

SIGMA = 2;
% Get matrix of histograms and cell array of image file names.
files = load_database_filenames('images');
% List all applicable distance measure specifiers for the
% compare_histograms function.
distance_meas = {'l2', 'chi2', 'hellinger', 'intersect'};
% Allocate matrix for storing distances. Each row stores distances for each
% comparison measure type.
distances = zeros([length(distance_meas), length(files)]);

% Get reference feature.
reference = get_gradient_feature(rgb2gray(imread(files{20})), SIGMA);

% Compute distances of images to reference feature.
for idx = 1:length(files)
	for meas = 1:length(distance_meas)
		feature_comp = get_gradient_feature(rgb2gray(imread(files{20})), SIGMA);
		distances(meas, idx) = compare_features(reference, feature_comp, distance_meas{meas});
	end
end

% Sort distances and get permutation of original indices.
[distances, perms] = sort(distances, 2);

% Set limit for how many images to display (displaying next lim closest matching images)
lim = 6;
% Go over measurement specifiers and plot 6 most similar by this measure.
for meas = 1:length(distance_meas)
	figure;
	for k = 1:lim
		subplot(1, lim, k);
		imshow(imread(files{perms(meas, k)}));
		title('Image ' + string(perms(meas, k)));
	end
end


