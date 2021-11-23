function [out]=RotZ(P,q)

%Rotates all points in P by and  angle q (deg) about the Z-axis

Rz=[ cos(-q)  sin(-q)  0  0
   -sin(-q)  cos(-q)  0  0
    0        0    1  0
    0        0    0  1];


N=size(P,1);
P=[P ones(N,1)];

for i=1:N,
    out(i,:)=Rz*P(i,:)';
end

out=out(:,1:3);