% function [] = myhist3_compare(image_name)
%
% Compare runtimes of myhist3 and myhist3_improved on a selected image.
function [] = myhist3_compare()
	% Parse image then run and time both functions.
	I = imread('lena.png');

	disp('Running myhist3...')
	tic; H1 = myhist3(I, 8); toc

	disp('Running myhist3_improved...')
	tic; H2 = myhist3_improved(I, 8); toc
	
	% Check if both functions returned the same result.
	if all(all(all(H1 == H2)))
		disp('Both functions produced the same result.')
	else
		disp('The results of the functions were NOT equal.')
end