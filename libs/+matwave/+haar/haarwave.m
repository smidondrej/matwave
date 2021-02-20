function matrix = haarwave(blocks)
% haarwave - wavelet transformation in Haar algorithm, it is its own
% inversion transformation
%   blocks:
%       input matrix of 2x2 matrices to be transform
%   matrix:
%       same format as blocks but each 2x2 block (matrix) is transformed

    [n,m,l,h] = size(blocks);
    matrix = zeros(n,m,l,h);
    haar = ones(2,2);
    haar(2,2) = -1;
    for i=1:l
        for j=1:h
            mat = haar*blocks(:,:,i,j);
            mat = mat*haar;
            mat = mat*(1/2);
            matrix(:,:,i,j) = mat;
        end
    end
end