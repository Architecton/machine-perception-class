% Script for comparing two implementations of nonmaxima suppresion
% algorithms.
%
% This script compares the runtime on a larger image and then computes the
% results for the Lena example image and visualizes the results side by
% side.

% Parse image and run implementation with nested loops three times and time.
I = rgb2gray(imread('dolomites.jpg'));
[Imag, Idir] = gradient_magnitude(I, 2);
disp('Running implementation with nested loops three times (dolomites.jpg)...')
disp('First iteration...')
tic; nonmaxima_suppression_line(Imag, Idir); toc;
disp('Second iteration...')
tic; nonmaxima_suppression_line(Imag, Idir); toc;
disp('Third iteration...')
tic; nonmaxima_suppression_line(Imag, Idir); toc;

% Run implementation without explicit loops three times and time.
disp('Running implementation without loops (dolomites.jpg)...')
disp('First iteration...')
tic; nonmaxima_suppression_line_improved(Imag, Idir); toc;
disp('Second iteration...')
tic; nonmaxima_suppression_line_improved(Imag, Idir); toc;
disp('Third iteration...')
tic; nonmaxima_suppression_line_improved(Imag, Idir); toc;

% Compute and plot results for example image side by side.
I2 = rgb2gray(imread('lena.png'));
[Imag2, Idir2] = gradient_magnitude(I2, 2);
disp('Running both implementations for a simple image to test equivalence (lena.png)... ')
Imax1 = nonmaxima_suppression_line(Imag2, Idir2);
Imax2 = nonmaxima_suppression_line_improved(Imag2, Idir2);
imshowpair(Imax1, Imax2, 'montage'); title('Results comparison');