% Read the images
image1 = imread('image1.jpg');
image2 = imread('image2.jpg');

% Convert to grayscale
grayImage1 = rgb2gray(image1);
grayImage2 = rgb2gray(image2);

% Step 1: Detect Features
points1 = detectSURFFeatures(grayImage1);
points2 = detectSURFFeatures(grayImage2);

% Extract features
[features1, validPoints1] = extractFeatures(grayImage1, points1);
[features2, validPoints2] = extractFeatures(grayImage2, points2);

% Step 2: Match Features
indexPairs = matchFeatures(features1, features2);
matchedPoints1 = validPoints1(indexPairs(:, 1), :);
matchedPoints2 = validPoints2(indexPairs(:, 2), :);

% Step 3: Compute Homography using RANSAC
[tform, inlierPoints1, inlierPoints2] = estimateGeometricTransform(matchedPoints1, matchedPoints2, 'projective');

% Step 4: Combine the Images
% Warp image2 to image1
outputView = imref2d(size(grayImage1));
warpedImage2 = imwarp(image2, tform, 'OutputView', outputView);

% Create a mask to blend the images
blendedImage = max(warpedImage2, image1);

% Display the result
figure;
imshow(blendedImage);
title('Panorama Image');
