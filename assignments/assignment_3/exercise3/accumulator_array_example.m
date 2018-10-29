% function [A] = accumulator_array_example(x, y)
%
% Trace possible parameter values for all lines that go through a point in
% image space. This means plotting possible solutions to the equation 
% rho = x*cos(theta) + y*sin(theta) where x and y are known.
function [A] = accumulator_array_example(x, y)
	bins_theta = 300; bins_rho = 300; % Resolution of the accumulator array
	max_rho = 100; % Usually the diagonal of the image.
	val_theta = (linspace(-90, 90, bins_theta) / 180) * pi; % Values of theta are known
	val_rho = linspace(-max_rho, max_rho, bins_rho); % Partition interval [-max_rho, max_rho] into bins_rho bins
	A = zeros(bins_rho, bins_theta);  % Define accumulator matrix.
	% compute rho for all values of theta (Solutions of line equations with x and y fixed).
	rho = x * cos(val_theta) + y * sin(val_theta);
	% Compute bins for rho. Notice that the solutions to the equation form
	% a sinusoidal wave.
	% Try plotting with command plot(1:length(bin_rho), bin_rho).
	bin_rho = round(((rho + max_rho) / (2 * max_rho)) * length(val_rho));
	for i = 1:bins_theta % Go over all bins for theta.
		if bin_rho(i) > 0 && bin_rho(i) <= bins_rho % Mandatory out-of-bounds check
			A(bin_rho(i), i) = A(bin_rho(i), i) + 1; % Increment the accumulator cells (voting)
		end
	end
end