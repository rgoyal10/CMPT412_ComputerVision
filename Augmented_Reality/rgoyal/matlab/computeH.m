function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
total_points = size(x1,1);
A = zeros(2 * total_points,9);
for i= 1:total_points
    x = x1(i,1);
    y = x1(i,2);
    xd = x2(i,1);
    yd = x2(i,2);
    
    A(2*i-1,:) = -[x,y,1,0,0,0,-x*xd, -xd*y,-xd];
    A(2*i,:) = -[0,0,0,x,y,1,-x*yd,-yd*y,-yd];
end
if total_points <= 4
    [U,S,V] = svd(A);
else
    [U,S,V] = svd(A,'econ');
end
H2to1 = reshape(V(:,9),3,3);
end
