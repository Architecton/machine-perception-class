% (a) 
% Canny edge detector is one of the most widely-used detectors of edges in images.
% In this assignment you will implement the rst steps of the Canny's algorithm that
% will be extended in throughout the assignment For start create function findedges
% following the example below.

% Extend the function with code that computes magnitudes of gradients Imag and re-
% turns a binary matrix Ie that shows the magnitudes that are higher than a specied
% threshold value theta :

I = rgb2gray(imread('museum.jpg'));  % Parse image.
Ie = findedges(I, 2, 20);			 % Find edges by setting treshold.
imagesc(Ie); colormap gray;			 % Display results.

% (b) %
% The function above returns a first approximation of the detected edges. Unfortu-
% nately, many of these edges are more than one pixel wide while we would usually
% like to have a one pixel wide edge detections. Use the function below within the
% function findedges to lter Imag before the thresholding operation. The function
% is a edge-specic local non-maxima suppression technique that searches the neigh-
% borhood of each pixel's magnitude Imag with respect to the local edge angle Idir
% and sets the magnitude value to 0 if it does not contain a maximum value in respect
% to the neighborhood magnitudes. Go through the code and analyze each line. Test
% the modified function findedges and visualize the result.

% See findedges2.m

% Test function.
input('Press enter to close all figures and continue.'); close all;
Ie = findedges2(I, 2);
imagesc(Ie); colormap gray;

% (c) % Non-maxima suppression algorithm can be implemented using ma-
% trix operations that results in significant performance improvements. Hint: function
% circshift can shift the entire matrix for a given number of elements. Using this
% function we can make a quick comparison of all elements with their corresponding
% top neighbors using I == circshift(I, [1, 0]) (we have to be careful with the
% border elements, however, there elements have handled separately in any case). Any
% innovative solution to this task will be accepted if it avoids explicit loops whenever
% possible. Demonstrate the new algorithm by comparison with the reference algo-
% rithm, you have to show result equality for all non-border elements and signicantly
% increased computational performance.

input('Press enter to close all figures and continue.'); close all;
% See nonmaxima_suppresion_line_improved.m

% Run comparison script.
nonmaxima_suppresion_comparison


% (d) % The last step of the Canny's algorithm is edge tracking using hysteresis
% thresholding. Replace the normal thresholding at the end of function findedges
% with hysteresis thresholding. This step is at first look difficult to implement, however,
% in Matlab/Octave we can accomplish this in a very compact way using functions like
% bwlabel, unique, and ismember. Hint: in the edge magnitude map we are looking
% for connected components in which all pixel values are above t_{low} and at least one
% value is also above I_{high} , where t_{low} < t_{high}. Any innovative solution to this task will
% be accepted if it avoids explicit loops whenever possible.
input('Press enter to close all figures and continue.'); close all;

% TODO: why don't the results match with example in the instructions??
% See hysteresis_tresh.m and findedges3.m
I = rgb2gray(imread('museum.jpg'));
figure; subplot(2, 2, 1);
imshow(I); title('original');
Ie1 = findedges(I, 1, 50);
subplot(2, 2, 2); imagesc(Ie1); colormap gray; title('tresholded (t = 50)');
Ie2 = findedges2(I, 1);
subplot(2, 2, 3); imagesc(Ie2); colormap gray; title('Nonmax. supp. (t = 50)');
Ie3 = findedges3(I, 1, 50, 20);
subplot(2, 2, 4); imagesc(Ie3); colormap gray; title('Hysteresis (high = 50, low = 20)');