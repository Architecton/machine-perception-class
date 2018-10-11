% (a) Implement a function myhist3 that computes a 3-D histogram from
% a three channel image (note that we assume that the image is in the RGB
% color space but if used with caution the function should also work for
% imaes in other color spaces). The resulting histogram is stored in a 3-D
% matrix.

% Parse image.
Umbrellas = imread('umbrellas.jpg');

% Compute 3D histogram values (see myhist3 function file)
H = myhist3(Umbrellas, 8);
% Plot results using function myhist3_plotter to replicate image in
% instructions.
myhist3_plotter(Umbrellas, H);


% 