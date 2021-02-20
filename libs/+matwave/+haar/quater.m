function [matrix, l, h] = quater(blocks, details)
% quater - pick up one of wavelet components from each block in blocks
%   blocks:
%       input matrix of 2x2 matrices
%   detais:
%       choise of frequency component:
%                       - HH -> 1
%                       - HL -> 2
%                       - LH -> 3
%                       - LL -> 4
%   matrix:
%       output component matrix
%   l, h:
%       output matrix size, l x h

    if details > 4 || details < 1
        throw('datails must be only 1,2,3 or 4');
    end
    [nrows, ncols, l, h] = size(blocks);
    if nrows ~= 2 || ncols ~= 2
        throw('blocks aint 2x2 matrices');
    end
    matrix = zeros(l,h);
    if details == 1
        for i=1:l
            for j=1:h
                matrix(i,j) = blocks(1,1,i,j);
            end
        end   
    end
    if details == 2
        for i=1:l
            for j=1:h
                matrix(i,j) = blocks(1,2,i,j);
            end
        end   
    end
    if details == 3
        for i=1:l
            for j=1:h
                matrix(i,j) = blocks(2,1,i,j);
            end
        end   
    end
    if details == 4
        for i=1:l
            for j=1:h
                matrix(i,j) = blocks(2,2,i,j);
            end
        end   
    end
end