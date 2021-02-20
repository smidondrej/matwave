% This script makes final image simulating compression
% and then defompression of an original image. It shows
% effects - quantization and type switching. The compression
% is created by three level of haar waveet transformation,
% where LL part is an input to next level of compression.
% Every other component is zigzag read and encoded by RLE
% and then finaly converted from double (to what was the
% image converted from origina uint8) to uint8. on last
% level each component is compressed to.
% 
% After this final image size and compress ratio is counted.
% Second half of the script makes decompression in similar
% manner as the compression part only in reverse way. Thus,
% each component is converted to double -> decompressed from
% RLE -> restored a matrix -> combine four components together
% -> transform and then enter abouve level. After all,
% restored image is saved.
%
% Branching during comression:
%
%                 o           - 0 level - original image
%                 |           - transform
%                 X           - split to LL, LH, HL, HH
%                / \          - enter 1 level
%      1.LL -   o   o o o     - LH, HL, HH
% transform -   |    \ \ \
%     split -   X     C C C   - compression + conversion
%              / \            - enter 2 level
%             o   o o o  ......


%% read the image and show it
img = imread('kodim01.png');
img = im2double(rgb2gray(img));
[l,h] = size(img);
figure;
imshow(img)
level = 10;

%% 1. level div
[blocks,a,b] = matwave.haar.split(img); 
block = matwave.haar.haarwave(blocks);
[matrix1,a,b] = matwave.haar.quater(block, 1);
[matrix2,a,b] = matwave.haar.quater(block, 2);
[matrix3,a,b] = matwave.haar.quater(block, 3);
[matrix4,a,b] = matwave.haar.quater(block, 4);

figure;
subplot(221);
imshow(im2uint8(matrix1));
subplot(222);
imshow(im2uint8(matrix2));
subplot(223);
imshow(im2uint8(matrix3));
subplot(224);
imshow(im2uint8(matrix4));

%% quantization 1. level
matrix2 = matwave.rle.quantization(matrix2, level);
matrix3 = matwave.rle.quantization(matrix3, level);
matrix4 = matwave.rle.quantization(matrix4, level);

%% encoding 1. level
a2 = matwave.rle.zigzag(matrix2);
a3 = matwave.rle.zigzag(matrix3);
a4 = matwave.rle.zigzag(matrix4);

[code2, cnt2] = matwave.rle.encode(a2);
[code3, cnt3] = matwave.rle.encode(a3);
[code4, cnt4] = matwave.rle.encode(a4);

%% conversion 1. level to uint8
min_val = min(code2);
max_val = max(code2);
scale2 = abs(max_val - min_val);
code2 = code2/scale2;
code2 = im2uint8(code2);

min_val = min(code3);
max_val = max(code3);
scale3 = abs(max_val - min_val);
code3 = code3/scale3;
code3 = im2uint8(code3);

min_val = min(code4);
max_val = max(code4);
scale4 = abs(max_val - min_val);
code4 = code4/scale4;
code4 = im2uint8(code4);

%% 2. level div
blocks = matwave.haar.split(matrix1);
block = matwave.haar.haarwave(blocks);
matrix11 = matwave.haar.quater(block, 1);
matrix12 = matwave.haar.quater(block, 2);
matrix13 = matwave.haar.quater(block, 3);
matrix14 = matwave.haar.quater(block, 4);

figure;
subplot(221);
imshow(im2uint8(matrix11));
subplot(222);
imshow(im2uint8(matrix12));
subplot(223);
imshow(im2uint8(matrix13));
subplot(224);
imshow(im2uint8(matrix14));

%% quantization 2. level
matrix12 = matwave.rle.quantization(matrix12, level);
matrix13 = matwave.rle.quantization(matrix13, level);
matrix14 = matwave.rle.quantization(matrix14, level);

%% encoding 2. level
a12 = matwave.rle.zigzag(matrix12);
a13 = matwave.rle.zigzag(matrix13);
a14 = matwave.rle.zigzag(matrix14);

[code12, cnt12] = matwave.rle.encode(a12);
[code13, cnt13] = matwave.rle.encode(a13);
[code14, cnt14] = matwave.rle.encode(a14);

%% conversion 2. level to uint8
min_val = min(code12);
max_val = max(code12);
scale12 = abs(max_val - min_val);
code12 = code12/scale12;
code12 = im2uint8(code12);

min_val = min(code13);
max_val = max(code13);
scale13 = abs(max_val - min_val);
code13 = code13/scale13;
code13 = im2uint8(code13);

min_val = min(code14);
max_val = max(code14);
scale14 = abs(max_val - min_val);
code14 = code14/scale14;
code14 = im2uint8(code14);

%% 3. level div
blocks = matwave.haar.split(matrix11);
block = matwave.haar.haarwave(blocks);
matrix111 = matwave.haar.quater(block, 1);
matrix112 = matwave.haar.quater(block, 2);
matrix113 = matwave.haar.quater(block, 3);
matrix114 = matwave.haar.quater(block, 4);

figure;
subplot(221);
imshow(im2uint8(matrix111));
subplot(222);
imshow(im2uint8(matrix112));
subplot(223);
imshow(im2uint8(matrix113));
subplot(224);
imshow(im2uint8(matrix114));

%% quantization 3. level
matrix111 = matwave.rle.quantization(matrix111, level);
matrix112 = matwave.rle.quantization(matrix112, level);
matrix113 = matwave.rle.quantization(matrix113, level);
matrix114 = matwave.rle.quantization(matrix114, level);

%% encoding 3. level
a111 = matwave.rle.zigzag(matrix111);
a112 = matwave.rle.zigzag(matrix112);
a113 = matwave.rle.zigzag(matrix113);
a114 = matwave.rle.zigzag(matrix114);

[code111, cnt111] = matwave.rle.encode(a111);
[code112, cnt112] = matwave.rle.encode(a112);
[code113, cnt113] = matwave.rle.encode(a113);
[code114, cnt114] = matwave.rle.encode(a114);

%% conversion 3. level to uint8
min_val = min(code111);
max_val = max(code111);
scale111 = abs(max_val - min_val);
code111 = code111/scale111;
code111 = im2uint8(code111);

min_val = min(code112);
max_val = max(code112);
scale112 = abs(max_val - min_val);
code112 = code112/scale112;
code112 = im2uint8(code112);

min_val = min(code113);
max_val = max(code113);
scale113 = abs(max_val - min_val);
code113 = code113/scale113;
code113 = im2uint8(code113);

min_val = min(code114);
max_val = max(code114);
scale114 = abs(max_val - min_val);
code114 = code114/scale114;
code114 = im2uint8(code114);

%% encoded -> compression ration check
final_size = length(code111);
final_size = final_size + length(code112);
final_size = final_size + length(code113);
final_size = final_size + length(code114);

final_size = final_size + length(code12);
final_size = final_size + length(code13);
final_size = final_size + length(code14);

final_size = final_size + length(code2);
final_size = final_size + length(code3);
final_size = final_size + length(code4);
% Compression memory size (raw data)
final_size = final_size * 2;
% final compression ratio
compression_ration = final_size / (l*h);

%% convertion 3. level to double
code111 = im2double(code111);
code111 = code111*scale111;

code112 = im2double(code112);
code112 = code112*scale112;

code113 = im2double(code113);
code113 = code113*scale113;

code114 = im2double(code114);
code114 = code114*scale114;

%% decodig 3. level
a111 = matwave.rle.decode(code111, cnt111);
a112 = matwave.rle.decode(code112, cnt112);
a113 = matwave.rle.decode(code113, cnt113);
a114 = matwave.rle.decode(code114, cnt114);

matrix111 = matwave.rle.izigzag(a111, l/8, h/8);
matrix112 = matwave.rle.izigzag(a112, l/8, h/8);
matrix113 = matwave.rle.izigzag(a113, l/8, h/8);
matrix114 = matwave.rle.izigzag(a114, l/8, h/8);

%% reconstruction 2. level
block = matwave.haar.unify(matrix111,matrix112,matrix113,matrix114);
blocks = matwave.haar.haarwave(block);
mat11 = matwave.haar.compile(blocks);
figure;
imshow(im2uint8(mat11))

%% convertion 2. level to double
code12 = im2double(code12);
code12 = code12*scale12;

code13 = im2double(code13);
code13 = code13*scale13;

code14 = im2double(code14);
code14 = code14*scale14;

%% decodig 2. level
a12 = matwave.rle.decode(code12, cnt12);
a13 = matwave.rle.decode(code13, cnt13);
a14 = matwave.rle.decode(code14, cnt14);
%%
matrix12 = matwave.rle.izigzag(a12, l/4, h/4);
matrix13 = matwave.rle.izigzag(a13, l/4, h/4);
matrix14 = matwave.rle.izigzag(a14, l/4, h/4);

%% reconstruction 1. level
block = matwave.haar.unify(mat11,matrix12,matrix13,matrix14);
blocks = matwave.haar.haarwave(block);
mat1 = matwave.haar.compile(blocks);
figure;
imshow(im2uint8(mat1))

%% convertion 1. level to double
code2 = im2double(code2);
code2(:,1) = code2(:,1)*scale2;

code3 = im2double(code3);
code3(:,1) = code3(:,1)*scale3;

code4 = im2double(code4);
code4(:,1) = code4(:,1)*scale4;

%% decodig 1. level
a2 = matwave.rle.decode(code2, cnt2);
a3 = matwave.rle.decode(code3, cnt3);
a4 = matwave.rle.decode(code4, cnt4);

matrix2 = matwave.rle.izigzag(a2, l/2, h/2);
matrix3 = matwave.rle.izigzag(a3, l/2, h/2);
matrix4 = matwave.rle.izigzag(a4, l/2, h/2);

%% reconstruction of the original image
block = matwave.haar.unify(mat1,matrix2,matrix3,matrix4);
blocks = matwave.haar.haarwave(block);
mat = matwave.haar.compile(blocks);
figure;
imshow(im2uint8(mat))

%% save restored image
imwrite(im2uint8(mat), 'kodim01_cm.png');
