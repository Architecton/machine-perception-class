% function [] = visualize_ld_pair(IL, ID, nbins)
%
% Visualize pairs of grayscale imagesc by plotting them and their
% histograms side by side.
%
function [] = visualize_ld_pair(IL, ID, nbins)
	subplot(2, 2, 1);	% Plot images side by side.
	imshow(IL); title('Light Image')
	subplot(2, 2, 2);
	imshow(ID); title('Dark Image')
	[HL, binsL] = myhist(IL, nbins); % Compute histograms.
	[HD, binsD] = myhist(ID, nbins); % Plot histograms side by side.
	subplot(2, 2, 3);
	bar(binsL, HL);
	subplot(2, 2, 4);
	bar(binsD, HD);
end