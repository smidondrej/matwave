function [matrix, l, h] = compile(blocks)
% compile - oposite of split function, takes matrix of 2x2 blocks and makes
% one whole matrix from it: block1 block2
%                           block3 block4
%   blocks:
%       input 4-D matrix
%   matrix:
%       compiled output matrix
%   l, h:
%       size of output matrix -> l x h

    [nrows, ncols, bl, bh] = size(blocks);
    if nrows ~= 2 || ncols ~= 2
        throw('blocks aint 2x2 matrices');
    end
    l = bl*2;
    h = bh*2;
    matrix = zeros(l,h);
    for i=1:bl
        for j=1:bh
            matrix((i-1)*2+1,(j-1)*2+1) = blocks(1,1,i,j);
            matrix((i-1)*2+1,(j-1)*2+2) = blocks(1,2,i,j);
            matrix((i-1)*2+2,(j-1)*2+1) = blocks(2,1,i,j);
            matrix((i-1)*2+2,(j-1)*2+2) = blocks(2,2,i,j);
        end
    end    
end