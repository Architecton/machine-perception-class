% (a) %% Compute convolution between the signal and kernel below by hand.

% See notes


% (b) %%

% Implement function simple_convolution.m , that uses 1 D signal I and a symmet-
% rical kernel g of size 2N + 1 , and computes convolution I_{g} . For the sake of simplicity
% you can start computing the convolution at i = N + 1 and nish with i = |I| − N .
% This means that the convolution will not be computed for the rst and the last N
% elements of the signal I . Test the implementation using a script that loads the sig-
% nal (file signal.txt) and the kernel (file kernel.txt) from the disk using function
% load and perform the convolution operation. Plot the input signal, kernel and the
% result of the convolution to the same figure.

% Question: Can you recognize the shape of the kernel? What is the sum of
% the elements in the kernel?

% The kernel forms the bell shape and resembles a normal/Gaussian
% distribution.

sum(g)

% The sum of the values is equal to 1, so it can be regarded as a
% probability density function.

% see simple_convolution.m

I = load('signal.txt'); g = load('kernel.txt');

Ig = simple_convolution(I, g);		% Compute convoluted signal.
figure; subplot(1, 2, 1); hold on;
plot(1:length(I), I, 'b'); % Plot signal, kernel and signal convoluted with kernel.
plot(1:length(g), g, 'g');
plot(1:length(Ig), Ig, 'r');


% (c) %%

% Compute the convolution again, but this time use Ig = conv(I, g, 'same') that
% is already included with Matlab/Octave. In what way does the result differ from
% the result of the function simple_convolution(I, g)? What is the cause of this?

% Plotting the results using the MATLAB convolution function.
Ig_ML = conv(I, g, 'same');
subplot(1, 2, 2);
plot(1:length(I), I, 'b'); hold on; % Plot signal, kernel and signal convoluted with kernel.
plot(1:length(g), g, 'g');
plot(1:length(Ig_ML), Ig_ML, 'r');

% Notice slight difference at bottom left tail of the convolution function.

% We can compare the function values.
abs(Ig - Ig_ML) < 1e-12

% Notice that the functions differ at places with indices less than N. This
% is because unlike the MATLAB conv function, our function only computes
% the convolution on [N, |I| - N]


% (d) %%

% An important property of the Gaussian function is that its value becomes very small
% for |x| > 3*sigma . A Gaussian kernel is therefore frequently bound to the size 2 ∗ 3*sigma + 1.
% Implement a function gauss that is given a parameter sigma and returns a corre-
% sponding Gaussian kernel.

% see gauss.m

% Generate kernel for sigma = 2 and make sure that the sum of its elements is 1 and that
% it is similar in shape to the kernel, stored in file kernel.txt. Plot Gaussian kernels
% for values of sigma = 0.5, 1, 2, 3, 4 on the same figure.

sigma_vals = [0.5, 1, 2, 3, 4];			% Define values for sigma.
plot_style = {'b','k','r', 'g', 'y'};	% Make cell array of plot styles.
legend_info = cell(1, 5);				% Allocate array for storing values of sigma.
figure; hold on;
for k = 1:length(sigma_vals)
	[g, x] = gauss(sigma_vals(k));		% Plot function.
	plot(x, g, plot_style{k});
	legend_info{k} = ['sigma = ' num2str(sigma_vals(k))];	% Add label.
end
legend(legend_info);										% Plot legend.

% The figure below shows two kernels (a) and (b) as well as signal (c).
% Sketch (do not focus on exact proportions of your drawing but rather on the under-
% standing of what you are doing) the resulting convolved signal of the given input
% signal and each kernel. You can optionally also implement a convolution demo based
% on the signals and your convolution code, but the important part here is your un-
% derstanding of the general idea of convolution.

% TODO

% The main advantage of convolution in comparison to correlation is associativity of
% operations. This allows us to pre-convolve multiple kernels instead of performing
% convolution with each one of them. Test this property by loading the signal from file
% signal.txt and then performing two consecutive convolutions on it, first one with
% a Gaussian kernel k1 with sigma = 2 , the second time with kernel k2 = [0.1, 0.6, 0.4].
% For the second k, try switch the order of kernels. Finally, use the same input signal
% and convolve it with a kernel that is a product of convolution k1 ∗ k2 . Plot all three
% results and compare them.

% Load signal vector.
signal = load('signal.txt');
k1 = gauss(2);			% Compute gaussian kernel with stdev of 2.
k2 = [0.1, 0.6, 0.4];	% Second gaussian kernel

figure;					% Compute and plot compositions of specified convolutions side by side.
subplot(1, 4, 1);
xlim([0, 40]);
plot(1:length(signal), signal);
title('s');

subplot(1, 4, 2);
r1 = conv(conv(I, k1, 'same'), k2, 'same');
plot(1:length(r1), r1);
title('(s * k1) * k2');

subplot(1, 4, 3);
r2 = conv(conv(I, k2, 'same'), k1, 'same');
plot(1:length(r2), r2);
title('(s * k2) * k1');

subplot(1, 4, 4);
r3 = conv(I, conv(k1, k2, 'same'), 'same');
plot(1:length(r3), r3);
title('s * (k1 * k2)')




