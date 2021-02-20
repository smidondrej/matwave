function output = quantization(input, level)
% Quantization - sorts all input values in number of values equals to level
%   input:
%       collection of values
%   level:
%       number of intervals the input domain is separated to

    min_val = min(input(:));
    max_val = max(input(:));
    step = abs(max_val - min_val)/level;
    output = step * floor(input/step + 1/2);
end