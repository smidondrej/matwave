% This script demonstrates quality degradation caused by type conversion


%% load image
img = imread('kodim01.png');
img = rgb2gray(img);
[l,h] = size(img);

%% show original image
figure;
imshow(img)
% conversion and transformation
[blocks,a,b] = matwave.haar.split(im2double(img));
block = matwave.haar.haarwave(blocks);
% uint8 conversion
min_val = min(block(:));
max_val = max(block(:));
scale = abs(max_val - min_val);
block = block/scale;
mat = matwave.haar.compile(block);
mat = im2uint8(mat);
%% conversion -> double and transformation
mat = im2double(mat);
mat = mat*scale;
block = matwave.haar.split(mat);
blocks = matwave.haar.haarwave(block);
res = matwave.haar.compile(blocks);
% show result image
figure;
imshow(res)
