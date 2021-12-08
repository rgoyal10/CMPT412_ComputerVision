% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
img_path = '../data/cv_cover.jpg';
cv_cover = imread(img_path);
[rows, columns, numberOfColorChannels] = size(cv_cover);

if numberOfColorChannels > 1
    gray_cv_cover = rgb2gray(cv_cover);
else
    gray_cv_cover = cv_cover;
end

%% Compute the features and descriptors

% Brief 
points1 = detectFASTFeatures(gray_cv_cover);
[desc1, locs1] = computeBrief(gray_cv_cover, points1.Location);
histogram_values = [];
for i = 0:36
    %% Rotate image
    rotated_image = imrotate(gray_cv_cover, (i+1)*10);
    %% Compute features and descriptors
    points2 = detectFASTFeatures(rotated_image);
    [desc2, locs2] = computeBrief(rotated_image, points2.Location);
    %% Match features
    threshold = 10.0;
    max_ratio = 0.68;
    indexPairs = matchFeatures(desc1, desc2,'MatchThreshold', threshold, 'MaxRatio', max_ratio);
    matchedPoints1 = locs1(indexPairs(:,1),:);
    matchedPoints2 = locs2(indexPairs(:,2),:);
    showMatchedFeatures(gray_cv_cover,rotated_image,matchedPoints1,matchedPoints2,'montage');
    
    total_matched_pairs = length( indexPairs(:,1));
    %% Update histogram
    histogram_values = [histogram_values, total_matched_pairs];
end
%% Display histogram
bar(histogram_values)





%using detectSURFFeatures and extractFeatures
points1 = detectSURFFeatures(gray_cv_cover);
[features1, valid_points1] = extractFeatures(gray_cv_cover, points1, 'Method', 'SURF');

histogram_values = [];
for i = 0:36
    %% Rotate image
    rotated_image = imrotate(gray_cv_cover, (i+1)*10);
    
    %% Compute features and descriptors
    points2 = detectSURFFeatures(rotated_image);
    [features2, valid_points2] = extractFeatures(rotated_image, points2, 'Method', 'SURF');
    
    %% Match features
    threshold = 10.0;
    max_ratio = 0.63;
    indexPairs = matchFeatures(features1, features2,'MatchThreshold', threshold, 'MaxRatio', max_ratio);
    matchedPoints1 = valid_points1(indexPairs(:,1),:);
    matchedPoints2 = valid_points2(indexPairs(:,2),:);
    showMatchedFeatures(gray_cv_cover,rotated_image,matchedPoints1,matchedPoints2,'montage');


    total_matched_pairs = length( indexPairs(:,1));

    %% Update histogram
    histogram_values = [histogram_values, total_matched_pairs];
end

bar(histogram_values)




