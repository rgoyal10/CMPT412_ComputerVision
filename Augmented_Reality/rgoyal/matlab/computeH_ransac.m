function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q2.2.3

total_points = size(locs1,1);
if total_points < 4
    num_random_points = total_points;
else
    num_random_points = 4;
end
total_iterations = 5000; %500
num_inliers = 0;
inliers =[];

for i =1:total_iterations

    k = randperm(total_points,num_random_points);
    p1 = zeros(num_random_points,2);
    p2 = zeros(num_random_points,2);
    for j = 1:num_random_points
        p1(j,:) = locs1(k(j),:); 
        p2(j,:) = locs2(k(j),:); 
    end
    H = computeH_norm(p1,p2);
    H = transpose(H);
    
    
    
    x = ones(3,total_points);
    x(1,:) = locs1(:,1);
    x(2,:) = locs1(:,2);
    x = H*x;
    x = x./x(3,:);
    
    y = ones(3,total_points);
    y(1,:) = locs2(:,1);
    y(2,:) = locs2(:,2);
    
    difference = x - y;
    
    first = difference(1,:).^2;
    second = difference(2,:).^2;
    difference = sqrt(first + second);
    
    
    
    current_count = 0;
    current_inliers = zeros(1,total_points);
    for m = 1:total_points
        if difference(m) < 10
            current_count = current_count+1;
            current_inliers(m) = 1; 
        end
    end
    
    if current_count > num_inliers
        num_inliers = current_count;
        inliers = current_inliers;
    end
end 

x_new = locs1(inliers==1,:); 
y_new = locs2(inliers==1,:);
bestH2to1 = computeH(x_new,y_new);


end

