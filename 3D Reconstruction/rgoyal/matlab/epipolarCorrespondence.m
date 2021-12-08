function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
points = zeros(size(pts1,1),2);

for i = 1:size(pts1,1)
    x = pts1(i,1);
    y = pts1(i,2);
    p1 = [x;y;1];
    epipolar_line = F*p1;
    epipolar_line = epipolar_line/-epipolar_line(2);
    windowSize=5;
    window1 = double(im1((y-windowSize):(y+windowSize), (x-windowSize):(x + windowSize),:));
    smallest_dist = inf;
    for j = x-10:x+10
        p2 = [j,epipolar_line(1)*j + epipolar_line(3),1];
        xd=p2(1);
        yd= p2(2);
        window2 = double(im2((yd-windowSize):(yd+windowSize), (xd-windowSize):(xd+ windowSize),:));
        difference = window1-window2;
        difference =  difference.^2;
        
        %Because of three dimensions
        addition = sum(difference);
        addition = sum(addition);
        addition = sum(addition);
        
        distance = sqrt(addition);
        if(distance <smallest_dist )
            smallest_dist = distance;
            points(i,1) = p2(1);
            points(i,2) = p2(2);
        end
    end
end
pts2 = points;

