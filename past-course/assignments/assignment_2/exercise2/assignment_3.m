% a %% 
% Write a function gaussfilter.m, that generates a Gaussian filter and applies it to
% a 2D image taking into account that the kernel is separable. Instead of the conv
% function use its analogy in 2D space, conv2. Generate a 1D kernel and use it to filter
% the image in the first dimension (Ib = conv2(I, g, 'same')) and then in the second
% dimension simply by transposing the kernel (Ig = conv2(Ib, g' ,'same')). Test
% the function by using the code snippet below that loads a reference image lena.png,
% transforms it to grayscale and corrupts it with a Gaussian noise (pixel value offset
% by a random number, sampled from a Gaussian distribution), as well as the salt-
% and-pepper noise (a portion of randomly selected pixels set to the lowest, black, or
% highest, white, value). Then the code uses the gaussfilter function (with sigma = 1 )
% to filter both corrupted images.