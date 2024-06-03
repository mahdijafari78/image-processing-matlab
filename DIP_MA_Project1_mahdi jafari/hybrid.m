warning('off','all')
clc;
clear all;
close all;
image1 = im2double(imread('data/1.jpg'));
image2 = im2double(imread('data/2.jpg'));
sigma_high = 2;
img1_filter = gaussian_filter_highpass(image1,10,1);
sigma_low = 1;
img2_filter = gaussian_filter_lowpass(image2,15,1);

hybrid_image = img2_filter + img1_filter;

figure(1);imshow(img1_filter+0.5);
figure(2);imshow(img2_filter);
results_img = make_hybrid_image(hybrid_image);
figure(3);imshow(results_img);


imwrite(img1_filter+0.5, 'results/high_pass.jpg', 'quality', 95);
imwrite(img2_filter, 'results/low_pass.jpg', 'quality', 95);
imwrite(hybrid_image, 'results/hybrid_image.jpg', 'quality', 95);
imwrite(results_img, 'results/hybrid_image_pyramid.jpg', 'quality', 95);