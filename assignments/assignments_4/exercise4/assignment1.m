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