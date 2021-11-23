function [out]=TransXYZ(P,XYZ)

%Translates all points in P XYZ

T=[ 1        0       0      0
    0        1       0      0
    0        0       1      0
    XYZ(1)  XYZ(2)  XYZ(3)  1];


N=size(P,1);
P=[P ones(N,1)];

for i=1:N,
    out(i,:)=P(i,:)*T;
end

out=out(:,1:3);