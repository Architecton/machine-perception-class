% function B = nonmaxima_suppression_box(A)
%
% Apply maximum filter using a 3 by 3 sliding box.
function B = nonmaxima_suppression_box(A)
	B = ordfilt2(A,9,ones(3,3));
end