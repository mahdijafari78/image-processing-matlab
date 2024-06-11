% Clear workspace and close all figures
clear;
close all;

% Load images
imageFiles = {'image1.jpg', 'image2.jpg', 'image3.jpg', 'image4.jpg', ...
              'image5.jpg', 'image6.jpg', 'image7.jpg', 'image8.jpg'};
numImages = length(imageFiles);
images = cell(1, numImages);

for i = 1:numImages
    images{i} = imread(imageFiles{i});
end

% Initialize the panorama with the first image
panorama = images{1};

for i = 2:numImages
    % Convert current panorama and the next image to grayscale
    grayPanorama = rgb2gray(panorama);
    grayNextImage = rgb2gray(images{i});
    
    % Step 1: Detect Features
    points1 = detectSURFFeatures(grayPanorama);
    points2 = detectSURFFeatures(grayNextImage);
    
    % Extract features
    [features1, validPoints1] = extractFeatures(grayPanorama, points1);
    [features2, validPoints2] = extractFeatures(grayNextImage, points2);
    
    % Step 2: Match Features
    indexPairs = matchFeatures(features1, features2);
    matchedPoints1 = validPoints1(indexPairs(:, 1), :);
    matchedPoints2 = validPoints2(indexPairs(:, 2), :);
    
    % Step 3: Compute Homography using RANSAC
    [tform, inlierPoints1, inlierPoints2] = estimateGeometricTransform(matchedPoints2, matchedPoints1, 'projective');
    
    % Step 4: Combine the Images
    % Warp the current image to the panorama
    outputView = imref2d(size(panorama));
    warpedImage = imwarp(images{i}, tform, 'OutputView', outputView);
    
    % Blend the warped image with the current panorama
    panorama = max(panorama, warpedImage);
end

% Display the final panorama
figure;
imshow(panorama);
title('Panorama Image');
