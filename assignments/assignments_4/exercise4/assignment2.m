% (a) %
% Write a function, descriptors_maglap , that computes a histogram of magnitude of
% partial image derivatives and Laplacian of a Gaussian around each point dened by
% vectory px and py . To compute the histograms use the function features_maglap
% that you can nd in the supplementary material. To use this function you will need
% some other functions (e.g. gradmag , laplace ) that you have implemented in the
% previous exercises. Histograms are returned as rows in a result matrix D.

% See features_maglap.m


% (b) %
% Write a function find_correspondences that is given two sets of descriptors of the
% same type, D1 and D2 and finds for each descriptor in D1 the most similar descriptor
% in D2 using the Hellinger distance:

% Demonstration
I1 = rgb2gray(imread('./graf/graf1_small.png'));
I2 = rgb2gray(imread('./graf/graf2_small.png'));
[px1, py1] = harris_points(I1, 3, 20000);
[px2, py2] = harris_points(I2, 3, 20000);
D1 = descriptors_maglap(I1, px1, py1, 30, 2, 15);
D2 = descriptors_maglap(I2, px2, py2, 30, 2, 15);

% Find correspondences between features found in images.
indices = find_correspondences(D1, D2);

% Sort px2 and py2 according to permutation in indices.
px2 = px2(indices);
py2 = py2(indices);
displaymatches(I1, px1, py1, I2, px2, py2)

% (c) %
% Implement a simple feature point matching algorithm. Write a function find_matches
% that is given two images as an input and returns a matrix M that contains pairs
% of the matched feature points from image 1 to image 2 and for each pair includes a
% similarity score. The matrix M should therefore contain ve columns: rst two for
% the coordinates of the feature point in the rst image, second two for the coordinates
% of the feature point in the second image, and the last one for the similarity value.
% Follow the algorithm below for the implementation:
input('Press enter to close all figures and continue. '); close all;

% Compute feature points.
[px1, py1] = harris_points(I1, 3, 50000);
[px2, py2] = harris_points(I2, 3, 50000);
% Compute descriptor vectors.
D1 = descriptors_maglap(I1, px1, py1, 41, 2, 16);
D2 = descriptors_maglap(I2, px2, py2, 41, 2, 16);
% Compute correspondences between feature vectors for both images.
[indices, distances] = find_correspondences(D1, D2);
px2 = px2(indices);
py2 = py2(indices);

% Sort matches by distance and get permutation.
[distances, perm] = sort(distances);
indices = indices(perm);
px1 = px1(perm);
py1 = py1(perm);
px2 = px2(perm);
py2 = py2(perm);

% If one feature in first image is mapped to more than one feature in
% second image, select only first mapping.
[~, u] = unique(indices);
% Construct matrix M.
M = [px1, py1, px2, py2, distances];
M = M(ismember(1:end, u), :);

% Display results.
displaymatches(I1, M(:, 1), M(:,2), I2, M(:,3), M(:,4))