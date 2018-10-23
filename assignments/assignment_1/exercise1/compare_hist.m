% function [] = compare_hist(file_name, nbins)
%
% Function used for visualizing the differences between user-defined myhist function
% results and the built-in MATLAB hist function.
function [] = compare_hist(file_name, nbins)
	% Parse image
	I = rgb2gray(imread(file_name));
	figure; clf;
	subplot(1, 2, 1);		
	
	% Plot results of MATLAB hist and myhist side by side.
	hist(double(I(:)), nbins)
	title('MATLAB hist')
	[H, bins] = myhist(I, nbins);
	subplot(1, 2, 2);
	bar(bins, H);
	title('myhist')
end