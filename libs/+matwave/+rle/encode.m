function [code, cnt] = encode(array)
% Decode - encodes given array by rle coding
%   array:
%       input to be encoded array
%   code:
%       rle decoded value array
%   cnt:
%       valus counter array

    len = length(array);
    tmp = zeros(len,1);
    tmp(1) = array(1);
    tmp_c = zeros(len,1,'uint8');
    tmp_c(1) = 1;
    idx = 1;
    for i=2:len
        if array(i) ~= array(i-1)
            idx = idx + 1;
            tmp(idx) = array(i);
            tmp_c(idx) = 1;
        else
            tmp_c(idx) = tmp_c(idx) + 1;
            if tmp_c(idx) == 255
                idx = idx + 1;
            end
        end
    end
    code = tmp(1:idx);
    cnt = tmp_c(1:idx);
end
