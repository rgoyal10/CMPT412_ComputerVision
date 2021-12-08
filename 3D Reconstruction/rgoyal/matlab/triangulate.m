function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%

pts3d = zeros(size(pts1,1),3);

p1 = P1(1,:);
p2 = P1(2,:);
p3 = P1(3,:);

p1_dash = P2(1,:);
p2_dash = P2(2,:);
p3_dash = P2(3,:);


for i = 1: size(pts1,1)
    
    x1 = pts1(i,1);
    y1 = pts1(i,2);
    x2 = pts2(i,1);
    y2 = pts2(i,2);
    
    A = [ y1 .* p3 - p2;
          p1 - x1 .* p3;
          y2 .* p3_dash - p2_dash;
          p1_dash - x2 .* p3_dash ];
      
    [~,~,V] = svd(A);
     V = V(:,end);
     v1 = V(1,1)./V(4,1);
     v2 = V(2,1)./V(4,1);
     v3 = V(3,1)./V(4,1);
     pts3d(i, :) = [v1,v2,v3];
     
end