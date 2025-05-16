clc;
clear;
close all

image = imread('data/image.jpg');
image_gray = rgb2gray(image);

[row, col] = find(corner_map(image_gray));

figure, imshow(image), hold on
plot(col, row, 'gX');
title('Detected Harris Corners');
frame = getframe(gca);
result_image = frame2im(frame);
imwrite(result_image,'output/image.jpg')