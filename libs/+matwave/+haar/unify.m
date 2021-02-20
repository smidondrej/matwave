function [blocks] = unify(LL, LH, HL, HH)
% unify - makes block of 2x2 blocks from components
%   components:
%       LL - a11 elemetns in each block
%       LH - a12 elemetns in each block
%       HL - a21 elemetns in each block
%       HH - a22 elemetns in each block
%   blocks:
%       output block of blocks: a11 a12
%                               a21 a22

    [bl, bh] = size(LL);
    blocks = zeros(2,2,bl,bh);
    for i=1:bl
        for j=1:bh
            blocks(1,1,i,j) = LL(i,j);
            blocks(1,2,i,j) = LH(i,j);
            blocks(2,1,i,j) = HL(i,j);
            blocks(2,2,i,j) = HH(i,j);
        end
    end 
end