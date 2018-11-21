% Parse testing image and get edges.
I = imread('eclipse.jpg');
Ig = rgb2gray(I);
Ie = findedges2(Ig, 3);
% Detect circle centers.
[x, y, A] = hough_find_circles(Ie, 700, 450, 50, 48);
% Draw the first 160 circles with the most votes.
hough_draw_circles(I, y(1:160), x(1:160), 48); title('Found circles');
figure; imagesc(A); title('Accumulator matrix');