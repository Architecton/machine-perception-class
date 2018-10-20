% function [] = myhist3_plotter(Original_image, H)
%
% Plot histogram matrix split into two plots returned by
% the myhist3 function along with the original image that was put into the myhist3 function.
function [] = myhist3_plotter(Original_image, H)
	figure(1); clf			% Create new figure.
	subplot(1, 4, 1);		% Make four subplots.
	imshow(Original_image);
	subplot(1, 4, 2);
	bar3(squeeze(sum(H, 1)))
	xlabel('Green'); ylabel('Blue');
	subplot(1, 4, 3);
	bar3(squeeze(sum(H, 2)))
	xlabel('Red'); ylabel('Blue');
	subplot(1, 4, 4)
	bar3(squeeze(sum(H, 3)))
	xlabel('Red'); ylabel('Green');
end