% (a) Implement a function myhist3 that computes a 3-D histogram from
% a three channel image (note that we assume that the image is in the RGB
% color space but if used with caution the function should also work for
% images in other color spaces). The resulting histogram is stored in a 3-D
% matrix.

% See myhist3.m

% (b) Test the myhist3 function on the image umbrellas.jpg from first
% exercise. Load the image, and calculate the histogram. Since 3 -D histograms are 
% difficult to visualize on a 2 -D screen, visualize the three marginal 2 -D histograms 
% that you obtain by summing up 1 the histogram matrix across a given dimension 
% and visualizing the result using bar3 function.

% Parse image.
Umbrellas = imread('umbrellas.jpg');

% Compute 3D histogram values (see myhist3 function file)
H = myhist3(Umbrellas, 8);
% Plot results using function myhist3_plotter to replicate image in
% instructions.
myhist3_plotter(Umbrellas, H);

% (c) Improve the performance of function myhist3 by getting rid of a
% double for loop. Try calculating the 1 -D index of a cell in advance and only iterate
% over a single vector of indices or go even further and try to get rid of the for
% loop by using accumarray . This task will only be accepted if you can show that
% the performance has indeed improved using timing functions tic and toc and you
% will show that you get the same results with both functions. Note that this task
% only makes sense performance-wise if you are using Octave or an older version of
% Matlab, newer versions of Matlab have been optimized to make the difference in the
% implementation almost negligible.

% See myhist3_improved.m and myhist3_compare.m


% (d) You will now implement a function for histogram comparison that is capable of
% performing comparison of two histograms using several distance measures that are
% defined upon histograms. This function accepts three arguments, two histograms
% and a string that identies of the distance used. It returns a computed distance
% value.

% see compare_histograms.m for implementation

% (e) Test your function.
input('Press enter to close all figures and continue.'); close all;
% Parse images.
O1 = imread('images/object_01_1.png');
O2 = imread('images/object_02_1.png');
O3 = imread('images/object_03_1.png');

% Compute a 8x8x8 bin 3-D histogram for each image. Vectorize all three histograms
% (convert them to 1 -D histograms by reshaping the matrix). Using the subplot
% function display all three images in one gure together with their corresponding
% histograms (e.g. in a 2x3 grid). Compute the L2 distance between histograms
% of object 1 and 2 as well as L2 distance between histograms of objects 1 and 3 .
% Remember that each histogram has to be normalized, so that the sum of its bins
% will be 1 . This should be automatically done by the myhist3 function.

% Compute histograms and vectorize them.
H1 = myhist3_improved(O1, 8); H1 = H1(:)';
H2 = myhist3_improved(O2, 8); H2 = H2(:)';
H3 = myhist3_improved(O3, 8); H3 = H3(:)';

% plot image is first row of plot.
figure(1); clf;
subplot(2, 3, 1);
imshow(O1); title('Image 1');
subplot(2, 3, 2);
imshow(O2); title('Image 2');
subplot(2, 3, 3);
imshow(O3); title('Image 3');

% Plot vectorized histograms and distances in second row of plot.
d = compare_histograms(H1, H1, 'l2');
subplot(2, 3, 4);
bar(H1(:)')
title('l2(H1, H1) = ' + string(d));

d = compare_histograms(H1, H2, 'l2');
subplot(2, 3, 5);
bar(H2(:)')
title('l2(H1, H2) = ' + string(d));

d = compare_histograms(H1, H3, 'l2');
subplot(2, 3, 6);
bar(H3(:)')
title('l2(H1, H3) = ' + string(d));

% Question: Which image (images/object_02_1.png or images/object_03_1.png)
% is more similar to image object_01_1.png considering the L2 distance? How about
% the other three distances? We can see that all three histograms contain a strongly
% expressed component (one bin has a much higher value than the others). Which
% color does this bin represent?

% By L2 distance, the third image is close to te first image. Let us check
% the distance using other measurements.
d_chi2_12 = compare_histograms(H1, H2, 'chi2');
d_chi2_13 = compare_histograms(H1, H3, 'chi2');
disp('Chi-square distance between histograms H1 and H2 is ' + string(d_chi2_12));
disp('Chi-square distance between histograms H1 and H3 is ' + string(d_chi2_13));


d_hellinger_12 = compare_histograms(H1, H2, 'hellinger');
d_hellinger_13 = compare_histograms(H1, H3, 'hellinger');
disp('Hellinger distance between histograms H1 and H3 is ' + string(d_hellinger_12));
disp('Hellinger distance between histograms H1 and H3 is ' + string(d_hellinger_13));

d_intersect_12 = compare_histograms(H1, H2, 'intersect');
d_intersect_13 = compare_histograms(H1, H3, 'intersect');
disp('Intersection distance between histograms H1 and H3 is ' + string(d_intersect_12));
disp('Intersection distance between histograms H1 and H3 is ' + string(d_intersect_13));

% We can see that the first image is closer to the third by all distance
% measurements.

% The bin which has the highest value in each histogram represents the
% black pixels (the background).

% (f) Now everything is ready to implement a simple image retrieval system using his-
% tograms and their mutual distances. Implement a function load_histogram_database
% that receives two input arguments, a path to a directory with images and the number
% of histogram bins. The function loads images, computes a RGB histogram 2 , trans-
% forms this 3-D histogram to 1-D histogram and returns a 2-D matrix of all histograms.
% The resulting matrix is assembled in a way that the i-th row contains a histogram
% of the i-th image.

% see load_histogram_database(directory, bins) for implementation.

% Use function load_histogram_database to get image histograms. Take histogram
% of image 20 in the list and compute histogram distances to all other images in the list
% (their histograms). Display the reference image and the first five images according
% to similarity (use function sort to order the sequence according to the similarity
% values). Plot the corresponding histograms in the same figure as well. Visualize
% results for all four distance measures that you have implemented.

input('Press enter to close all figures and continue.'); close all;
% Get matrix of histograms and cell array of image file names.
[histograms, files] = load_histogram_database('images', 8);
% List all applicable distance measure specifiers for the
% compare_histograms function.
distance_meas = {'l2', 'chi2', 'hellinger', 'intersect'};
reference = histograms(20, :);	% Take the 20. histogram as reference.
% Allocate matrix for storing distances. Each row stores distances for each
% comparison measure type.
distances = zeros([length(distance_meas), size(histograms, 1)]);
% Go over histograms.
for idx = 1:size(histograms, 1)
	for meas = 1:length(distance_meas)
		distances(meas, idx) = compare_histograms(reference, histograms(idx, :), distance_meas{meas});
	end
end

% Sort distances and get permutation of original indices.
[distances, perms] = sort(distances, 2);

% Set limit for how many images to display (displaying next lim closest matching images)
lim = 6;
% Go over measurement specifiers.
for meas = 1:length(distance_meas)
	figure(meas);
	for k = 1:lim
		subplot(2, lim, sub2ind([lim, 2], k, 1));
		imshow(imread(files{perms(meas, k)}));
		title('Image ' + string(perms(meas, k)));
		% Plot histogram beneath image. Notice that linear indices go from
		% left to right in subplots.
		subplot(2, lim, sub2ind([lim, 2], k, 2));
		bar(histograms(perms(meas, k), :));
		title(string(distance_meas{meas}) + ' = ' + string(sprintf('%1.2f', distances(meas, k))));
	end
end

% Question: Use 8 bins per color channel  which distance measure is in your opinion
% best suited for the specific task (elaborate your answer)? How does the retrieved
% sequence change if we change the number of histogram bins (e.g. 16 or 32 )? Does
% the time required to perform the operation also change?

% The best performance is achieved using Hellinger distance as it is most
% suited for the task of robustly identifying visually similar images.
%
% The last two retrieved images change to pill bottles if we increase the bins to 16 or 32. 
% The computational time rises significantly with the increase in the
% number of bins.


% (g) A handy tool for distance visualization is to plot a graph that displays image in-
% dices on the x axis and a distance to the reference image on y axis. Using this
% kind of visualization you can see if the most similar images are indeed more similar
% to the reference image than the rest of the image set. Write a script that visual-
% izes a sorted and unsorted sequence of distances this way. In both cases highlight
% the top ve matches by drawing circles around their corresponding points (see the
% documentation of function plot for more information).

% see histogram_distance_visualization.m

input('Press enter to close all figures and continue.'); close all;
histogram_distance_visualization

% (h) One of the problems that this simple retrieval system has is strong
% influence of the dominant colors that are present in all images and therefore carry
% no discriminative information. Analyze the presence of various colors by summing
% up image histograms bin-wise and displaying the resulting histogram. Which bin
% dominates in this combined histogram? To address this we will implement a sim-
% ple frequency-based weighting technique, similar to the ones that are employed in
% document-retrieval systems. Use the frequency histogram that you have computed
% to determine weighting factors for each bin. The idea is that the bins, that are
% strongly represented in all image histograms get lower weight and the bins that are
% less represented (and therefore could be more discriminative) get a higher weight 3 .
% Multiply each histogram bin by bin with its corresponding weight (and do not forget
% to normalize the histogram after that). Then compare the retrieval process for the
% weighted and unweighted histograms (check which are the most similar images, and
% what are their distances to the reference image). Write down your observations. In
% which ways did the weighting improve the retrieval results?
input('Press enter to close all figures and continue.'); close all;

sum_histograms = sum(histograms, 1);					% Sum up the histograms and normalize.
sum_histograms = sum_histograms/sum(sum_histograms);
figure; bar(sum_histograms);
[max_freq, idx] = max(sum_histograms);					% Notice that black is by far the dominant color in the summed histogram.
disp('Maximum relative frequency in histogram is ' + string(max_freq) + ' at index ' + string(idx));

% We will compute the weights using the exponential function.
% Compute weight for each bin
LAMBDA = 50;	% Set lambda constant.
weights = arrayfun(@(x) exp(-LAMBDA*x), sum_histograms);

% Apply weights to histogram.
histograms_weighted = histograms;
% Go over the histograms 
for r = 1:size(histograms_weighted, 1)
	histograms_weighted(r, :) = histograms_weighted(r, :) .* weights;
	histograms_weighted(r, :) = histograms_weighted(r, :) / sum(histograms_weighted(r, :));
end

% Compare retrieval process
comparison_results = compare_retrieval(histograms, histograms_weighted);

% Explain results.
disp('## UNWEIGHTED HISTOGRAMS COMPARSION RESULTS: ##')
disp('distances from reference using Euclidean distance:')
disp(comparison_results(1, :))

disp('Indices of closest images to reference using Euclidean distance:')
disp(comparison_results(5, :))

disp('distances from reference using Chi-square distance:')
disp(comparison_results(2, :))

disp('Indices of closest images to reference using Chi-square distance:')
disp(comparison_results(6, :))

disp('distances from reference using Hellinger distance')
disp(comparison_results(3, :))

disp('Indices of closest images to reference using Hellinger distance:')
disp(comparison_results(7, :))

disp('distances from reference using intersect distance')
disp(comparison_results(4, :))

disp('Indices of closest images to reference using intersect distance:')
disp(comparison_results(8, :))
disp('#############################################')

disp('## WEIGHTED HISTOGRAMS COMPARSION RESULTS: ##')
disp('distances from reference using Euclidean distance:')
disp(comparison_results(9, :))

disp('Indices of closest images to reference using Euclidean distance:')
disp(comparison_results(13, :))

disp('distances from reference using Chi-square distance:')
disp(comparison_results(10, :))

disp('Indices of closest images to reference using Chi-square distance:')
disp(comparison_results(14, :))

disp('distances from reference using Hellinger distance')
disp(comparison_results(11, :))

disp('Indices of closest images to reference using Hellinger distance:')
disp(comparison_results(15, :))

disp('distances from reference using intersect distance')
disp(comparison_results(12, :))

disp('Indices of closest images to reference using intersect distance:')
disp(comparison_results(16, :))
disp('#############################################')

% Interpretation:
% The weights put more emphasis on colors that determine a particular image
% better - colors that are not shared as much between images. This puts
% less emphasis the shared black background and more emphsasis on the
% colors of the objects.