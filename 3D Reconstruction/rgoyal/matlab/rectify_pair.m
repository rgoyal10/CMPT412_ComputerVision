function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m

%optical center c1 and c2 of each camera
c1 = -(inv (K1 * R1) )* (K1*t1);
c2 = -(inv (K2 * R2) )* (K2*t2);

diff = c1-c2;
total = sum( (diff).^2);
total = sqrt(total);
r1 = diff/total;
r2 = cross(R1(3,:),r1);
r2 = r2';
r3 = cross(r2,r1);

Rotation_matrix = [r1 r2 r3]';
new_K = K2;

t1n = - Rotation_matrix * c1;
t2n = - Rotation_matrix * c2;
M1 = (new_K*Rotation_matrix) * (inv(K1*R1));
M2 = (new_K*Rotation_matrix) * (inv(K2*R2));
K1n = new_K;
K2n = new_K;
R1n = Rotation_matrix;
R2n = Rotation_matrix;












