which -all hold
close all
clear

%Load an image, a CAD model cad, 2D points x and 3D points X from PnP.mat.
params = load('../data/PnP.mat');
cad = params.cad;
image = params.image;
x = params.x;
X = params.X;

%Run estimate_pose and estimate_params to estimate camera matrix P, intrinsic matrix K, rotation matrix R, and translation t.
P = estimate_pose(x, X);
[K, R, t] = estimate_params(P);

%Use your estimated camera matrix P to project the given 3D points X onto the image.
points = P*[X; ones(1, size(X,2))];
points = points ./ points(3,:);
x_points = points(1,:);
y_points = points(2,:);
figure
imshow(image);
hold on
plot(x_points, y_points, 'go','MarkerSize',15 ,'LineWidth', 1);
plot(x(1,:),x(2,:), 'r.', 'LineWidth', 2);
hold off

faces = cad.faces;
vertices = cad.vertices;

%Plot the given 2D points x and the projected 3D points on screen. An example is shown at the left below. Hint: use plot.
figure
trimesh(faces,vertices(:,1), vertices(:,2), vertices(:,3),'EdgeColor', 'black');

%Draw the CAD model rotated by your estimated rotation R on screen. An example is shown at the middle below. Hint: use trimesh.
figure
rotated = [R,t;[0,0,0,1]] * [vertices.';ones(1,size(vertices,1))];
trimesh(faces,rotated(1,:), rotated(2,:), rotated(3,:),'EdgeColor', 'blue');

%Project the CAD’s all vertices onto the image and draw the projected CAD model overlapping with the 2D image. An example is shown at the right below. Hint: use patch.
figure
projected = P * [vertices.'; ones(1,size(vertices,1))];
projected = projected ./ projected(3,:);

hold on
imshow(image)
patch('Faces',faces(:,1:2),'Vertices', [projected(1,:).', projected(2,:).'],'EdgeColor', 'red')
hold off


