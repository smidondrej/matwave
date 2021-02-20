function array = decode(code, cnt)
% Decode - decodes given rle code
%   code:
%       encoded values array
%   cnt:
%       encoded values counter array
%   array:
%       decoded output array

    l = length(code);
    len = sum(cnt);
    array = zeros(1,len);
    idx = 1;
    for i=1:l
        while cnt(i) > 0
            array(idx) = code(i);
            idx = idx + 1;
            cnt(i) = cnt(i) - 1;
        end
    end
end

