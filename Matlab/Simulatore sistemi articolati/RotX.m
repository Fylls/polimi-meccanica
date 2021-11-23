function [out]=RotX(P,q)

%Rotates all points in P by and  angle q (deg) about the X-axis

R=[ 1        0       0      0
    0      cos(-q)  sin(-q)   0
    0     -sin(-q)  cos(-q)   0
    0        0       0      1];


N=size(P,1);
P=[P ones(N,1)];

for i=1:N,
    out(i,:)=R*P(i,:)';
end

out=out(:,1:3);