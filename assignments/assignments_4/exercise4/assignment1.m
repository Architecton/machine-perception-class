% (a) %
% Implement a function hessian_points, that computes a Hessian determinant using
% the equation (2) for each pixel of the input image. As this computation can be
% very slow if done pixel by pixel, you have to implement it using vector operations
% (without explicit for loops). Test the function using image from test_points.png
% as your input (do not forget to convert it to gray-scale) and visualize the result.

% see hessian_points.m

% Demonstration


% (b) %
% Extend the function hessian_points by implement a non-maximum suppression
% post-processing step that only retains responses that are higher than all the neigh-
% borhood responses and whose value is higher than a given threshold value thresh .
% In result vectors px and py the function returns (x, y) coordinates of detected feature
% points.

% see hessian_points_ext.m

% Demonstration

input('Press enter to close all figures and continue to next section.'); close all;

% Parse image.
I_test_points = rgb2gray(imread('test_points.png'));

% Compute Hessian points above treshold
[y1, x1] = hessian_points_ext(I_test_points, 3, 15000);
[y2, x2] = hessian_points_ext(I_test_points, 6, 15000);
[y3, x3] = hessian_points_ext(I_test_points, 9, 15000);

% Plot results.
subplot(2, 3, 1); imagesc(hessian_points(I_test_points, 3)); colormap gray; title('Hessian $$\sigma$$ = 3', 'interpreter', 'latex');
subplot(2, 3, 2); imagesc(hessian_points(I_test_points, 6)); colormap gray; title('Hessian $$\sigma$$ = 6', 'interpreter', 'latex');
subplot(2, 3, 3); imagesc(hessian_points(I_test_points, 9)); colormap gray; title('Hessian $$\sigma$$ = 9', 'interpreter', 'latex');
subplot(2, 3, 4); imagesc(I_test_points); colormap gray; hold on;
plot(x1, y1, 'rx');
subplot(2, 3, 5); imagesc(I_test_points); colormap gray; hold on;
plot(x2, y2, 'rx');
subplot(2, 3, 6); imagesc(I_test_points); colormap gray; hold on;
plot(x3, y3, 'rx');

% (c) %
% Implement function harris_points that computes values of equation (7) for all
% pixels, performs non-maximum suppression post-processing step as well as thresh-
% olding using threshold thresh , The function returns feature point coordinates in
% vectors px and py.

% see harris_points.m

% Demonstration

input('Press enter to close all figures and continue to next section.'); close all;

% Compute Hessian points above treshold
[px1, py1, T1] = harris_points(I_test_points, 3, 15000);
[px2, py2, T2] = harris_points(I_test_points, 6, 15000);
[px3, py3, T3] = harris_points(I_test_points, 9, 15000);

% Plot results.
subplot(2, 3, 1); imagesc(T1); colormap gray; title('Harris $$\sigma$$ = 3', 'interpreter', 'latex');
subplot(2, 3, 2); imagesc(T2); colormap gray; title('Harris $$\sigma$$ = 6', 'interpreter', 'latex');
subplot(2, 3, 3); imagesc(T3); colormap gray; title('Harris $$\sigma$$ = 9', 'interpreter', 'latex');
subplot(2, 3, 4); imagesc(I_test_points); colormap gray; hold on;
plot(px1, py1, 'rx');
subplot(2, 3, 5); imagesc(I_test_points); colormap gray; hold on;
plot(px2, py2, 'rx');
subplot(2, 3, 6); imagesc(I_test_points); colormap gray; hold on;
plot(px3, py3, 'rx');

% Experiment with different parameter values. Do the feature points of both detectors appear on the same
% structures in the image?

% TODO