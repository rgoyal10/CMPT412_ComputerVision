function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points

%disp(x1)


x1_x = x1(:,1);
x1_y = x1(:,2);
centroid1 = [mean(x1_x) mean(x1_y)];
%disp(centroid1)

x2_x = x2(:,1);
x2_y = x2(:,2);
centroid2 = [mean(x2_x) mean(x2_y)];
%disp(centroid2)


%% Shift the origin of the points to the centroid
x1_row = x1(:,1);
x1(:,1) = x1_row - centroid1(1);

x1_col = x1(:,2);
x1(:,2) = x1_col - centroid1(2);
%disp(x1)

x2_row = x2(:,1);
x2(:,1) = x2_row - centroid2(1);

x2_col = x2(:,2);
x2(:,2) = x2_col - centroid2(2);
%disp(x2)



%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
x1_col1_square = x1(:,1).^2;
x1_col2_square = x1(:,2).^2;
sum1 = x1_col1_square + x1_col2_square;
sum1 = sqrt(sum1);
mean1 = mean(sum1);

x2_col1_square = x2(:,1).^2;
x2_col2_square = x2(:,2).^2;
sum2 = x2_col1_square + x2_col2_square;
sum2 = sqrt(sum2);
mean2 = mean(sum2);



x1 = x1 *(sqrt(2)/mean1);
x2 = x2 *(sqrt(2)/mean2);



%% similarity transform 1
T1 = [1,0,-centroid1(1);0,1,-centroid1(2);0,0,1];
T1(1,:) = T1(1,:)* (sqrt(2)/mean1);
T1(2,:) = T1(2,:)* (sqrt(2)/mean1);


%% similarity transform 2
T2 = [1,0,-centroid2(1);0,1,-centroid2(2);0,0,1];
T2(1,:) = T2(1,:)* (sqrt(2)/mean2);
T2(2,:) = T2(2,:)* (sqrt(2)/mean2);

%% Compute Homography

H = computeH(x1,x2);

%% Denormalization
H2to1 = T2\H*T1;
H2to1 = transpose(H2to1);
