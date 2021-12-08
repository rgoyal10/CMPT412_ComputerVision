function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary


[rows1, columns1, numberOfColorChannels1] = size(I1);
if numberOfColorChannels1 > 1
    image1 = rgb2gray(I1);
else
    image1 = I1;
end

[rows2, columns2, numberOfColorChannels2] = size(I2);
if numberOfColorChannels2 > 1
    image2 = rgb2gray(I2);
else
    image2 = I2;
end

%% Detect features in both images
points1 = detectFASTFeatures(image1);
points2 = detectFASTFeatures(image2);

%% Obtain descriptors for the computed feature locations
[desc1, locs1] = computeBrief(image1, points1.Location);
[desc2, locs2] = computeBrief(image2, points2.Location);

%% Match features using the descriptors

%default max ratio is 0.6 and default threshold is 1.0
threshold = 10.0;
max_ratio = 0.68; %0.63
indexPairs = matchFeatures(desc1, desc2,'MatchThreshold', threshold, 'MaxRatio', max_ratio); 

matchedPoints1 = locs1(indexPairs(:,1),:);
matchedPoints2 = locs2(indexPairs(:,2),:);

locs1 = locs1(indexPairs(:,1),:);
locs2 = locs2(indexPairs(:,2),:);

showMatchedFeatures(image1,image2,matchedPoints1,matchedPoints2,'montage');

end

