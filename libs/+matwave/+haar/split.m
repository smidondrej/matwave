function [blocks, bl, bh] = split(matrix)
% split - splits a matrix to blocks of size 2x2
%   matrix:
%       matrix to by split
%   blocks:
%       output matrix of 2x2 matrices
%   bl, bh:
%       size of output matrix bl x bh

    [l,h] = size(matrix);
    if mod(l,2) ~= 0 || mod(h,2)
        throw('matrix cant be devided to 2x2 blocks');
    end
    bl = l/2;
    bh = h/2;
    blocks = zeros(2,2,bl,bh);
    for i=1:bl
        for j=1:bh
            blocks(1,1,i,j) = matrix((i-1)*2+1,(j-1)*2+1);
            blocks(1,2,i,j) = matrix((i-1)*2+1,(j-1)*2+2);
            blocks(2,1,i,j) = matrix((i-1)*2+2,(j-1)*2+1);
            blocks(2,2,i,j) = matrix((i-1)*2+2,(j-1)*2+2);
        end
    end
end