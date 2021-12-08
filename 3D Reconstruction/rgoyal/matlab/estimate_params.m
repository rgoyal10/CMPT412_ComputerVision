function [K, R, t] = estimate_params(P)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[~,~,V] = svd(P);
v = V(:,end);
c = v(1:3,:)/v(4,:);

A = P(1:3,1:3);

P = [0 0 1;
     0 1 0;
     1 0 0];
 
 A_hash = P * A;
 A = transpose(A_hash);

a1 =  A(:,1);
a2 =  A(:,2);
a3 =  A(:,3);
u1 = a1;
e1 = u1/ norm(u1);
u2 = a2 - (dot(a2,e1) * e1);
e2 = u2/ norm(u2);
u3 = a3 - (dot(a3,e1) * e1) - (dot(a3,e2) * e2);
e3 = u3/ norm(u3);
Q_hash = [e1 e2 e3];
R_hash = [dot(a1,e1) dot(a2,e1) dot(a3,e1) ; 
    0 dot(a2,e2) dot(a3,e2) ; 
    0 0 dot(a3,e3)];

Q_dash = P * transpose(Q_hash);
R_dash = P * transpose(R_hash) * P;

K = R_dash;
R = Q_dash;
t = - R * c;
end

