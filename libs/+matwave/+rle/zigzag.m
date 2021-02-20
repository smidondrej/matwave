function [array, l, h] = zigzag(matrix)
% ZigZag - inline zigzag reading matrix
%   matrix:
%       rows x columns matrix to be narrowed in the zigzag way
%   array:
%       output array
%   l, h:
%       matrix size l x h

    [l, h] = size(matrix);
    % indices of elements
    ind = reshape(1:numel(matrix), [l, h]);
    % get the anti-diagonals
    ind = fliplr(spdiags(fliplr(ind)));
    % reverse order of odd columns
    ind(:,1:2:end) = flipud(ind(:,1:2:end));
    % keep non-zero indices
    ind(ind==0) = [];

	array = matrix(ind);
end