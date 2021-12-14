function [out]=RotZ2d(P,q)
%ROTZ2D Rotates all 2D points in P by and  angle q (rad) about the Z-axis
%
%Copyright (c) Murat TAHTALI, UNSW@ADFA, 2007

Rz=[ cos(q)  sin(q)  0
    -sin(q)  cos(q)  0
    0        0    1  ];

N=size(P,1);
P=[P ones(N,1)];

for i=1:N,
    out(i,:)=Rz*P(i,:)';
end

out=out(:,1:2);