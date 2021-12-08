% A test script using templeCoords.mat
%
% Write your code here
%
%Load the two images and the point correspondences from someCorresp.mat
image1 = imread("../data/im1.png");
image2 = imread("../data/im2.png");
someCorresp = load('../data/someCorresp.mat');

pts1 = someCorresp.pts1;
pts2 = someCorresp.pts2;
M = someCorresp.M;

% Run eightpoint to compute the fundamental matrix F
F = eightpoint(pts1, pts2, M);

% Load the points in image 1 contained in templeCoords.mat and run your epipolarCorrespondences on them to get the corresponding points in image 
templeCoords = load('../data/templeCoords.mat');
image1_pts1 = templeCoords.pts1;
image1_pts2 = epipolarCorrespondence(image1, image2, F, image1_pts1);

% Load intrinsics.mat and compute the essential matrix E.
intrinsics = load('../data/intrinsics.mat');
K1 = intrinsics.K1;
K2 = intrinsics.K2;
E = essentialMatrix(F, K1, K2);

% Compute the first camera projection matrix P1 and use camera2.m to compute the four candidates for P2
 identity = eye(3);
 add_col = [0;0;0];
 identity = [identity add_col];
 P1 = K1* identity;
 P2_candidates = camera2(E);
 
 max_depth = -inf;
 
 
 
 
 
%  Run your triangulate function using the four sets of camera matrix candidates, the points from templeCoords.mat and their computed correspondences.
for i = 1:4
    P2 = P2_candidates(:,:,i);
    pts3d = triangulate(P1, image1_pts1, P2, image1_pts2 );
    if max_depth <= sum(pts3d(:,3)>0)
        max_depth = sum(pts3d(:,3)>0);
        plot_y = pts3d;
        num_proj = i;
    end
end

% Figure out the correct P2 and the corresponding 3D points.
% Use matlab’s plot3 function to plot these point correspondences on screen. Please type “axis equal” after “plot3” to scale axes to the same unit.
plot3(plot_y(:, 1), plot_y(:, 3), -plot_y(:, 2), '.'); axis equal

% save extrinsic parameters for dense reconstruction
R1 =  eye(3);
t1 = [0;0;0];
R2 = P2_candidates(:, 1:3, num_proj);
R2 (1:3,2) = -R2 (1:3,2); 
R2 (1:3,3) = -R2 (1:3,3);
R2
t2 = P2_candidates(:, 4, num_proj)
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');

