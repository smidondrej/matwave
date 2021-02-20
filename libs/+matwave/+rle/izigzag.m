function matrix = izigzag(array, l, h)
% iZigZag - makes l x h matrix from zigzag array
%   array:
%       output array
%   l, h:
%       matrix size l x h
%   matrix:
%       rows x columns matrix to be narrowed in the zigzag way

    idx = zeros(l,h);
    for i=1:l*h
        idx(floor((i-1)/h)+1,mod((i-1),h)+1) = i;
    end
    % indices of elements
    ind = reshape(1:numel(idx), size(idx));
    % get the anti-diagonals
    ind = fliplr(spdiags(fliplr(ind)));
    % reverse order of odd columns
    ind(:,1:2:end) = flipud(ind(:,1:2:end));
    % keep non-zero indices
    ind(ind==0) = [];
    resize = idx(ind);
    matrix = zeros(h,l);
    matrix(resize) = array;
    matrix = matrix';
end

