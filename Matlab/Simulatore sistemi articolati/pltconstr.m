function []=pltconstr(x,y,z,dr,scl)
% x=0;
% y=0;
% z=0;
hold on
n=20;

a=1;
b=2*a*sin(pi/3);
c=b/10;
d=2*a/(n-1);

p=[0 0 0
   a -b 0
   -a -b 0
   0 0 0]*scl;

[p1,p2]=setRot(p,dr);
p1=TransXYZ(p1,[x y z]);
p2=TransXYZ(p2,[x y z]);
plot3(p1(:,1),p1(:,2),p1(:,3),'r','LineWidth',1)
plot3(p2(:,1),p2(:,2),p2(:,3),'r','LineWidth',1)

l=[0 0 0
   -d -c 0]*scl;

h=l+[a -b 0;a -b 0]*scl;
for i=1:n,
    [h1,h2]=setRot(h,dr);
    h1=TransXYZ(h1,[x y z]);
    h2=TransXYZ(h2,[x y z]);
    plot3(h1(:,1),h1(:,2),h1(:,3),'r','LineWidth',1)    
    plot3(h2(:,1),h2(:,2),h2(:,3),'r','LineWidth',1)    
    h=h+[-d 0 0;-d 0 0]*scl;  
end


function [out1,out2]=setRot(p,dr)

switch dr
    case 1
        out1=RotZ(p,-pi/2);
        out2=RotX(out1,pi/2);
    case 2
        out1=p;
        out2=RotY(p,pi/2);
    case 3
        out1=RotX(p,-pi/2);
        out2=RotZ(out1,pi/2);
end


% function [out]=RotZ(P,q)
% 
% %Rotates all points in P by and  angle q (deg) about the Z-axis
% 
% Rz=[ cos(q)  sin(q)  0  0
%    -sin(q)  cos(q)  0  0
%     0        0    1  0
%     0        0    0  1];
% 
% 
% N=size(P,1);
% P=[P ones(N,1)];
% 
% for i=1:N,
%     out(i,:)=Rz*P(i,:)';
% end
% 
% out=out(:,1:3);
% 
% function [out]=RotY(P,q)
% 
% %Rotates all points in P by and  angle q (deg) about the Y-axis
% 
% R=[ cos(q)  0    -sin(q)   0
%     0        1       0      0
%     sin(q)   0    cos(q)    0
%     0        0       0      1];
% 
% 
% N=size(P,1);
% P=[P ones(N,1)];
% 
% for i=1:N,
%     out(i,:)=R*P(i,:)';
% end
% 
% out=out(:,1:3);
% 
% function [out]=RotX(P,q)
% 
% %Rotates all points in P by and  angle q (deg) about the X-axis
% 
% R=[ 1        0       0      0
%     0      cos(q)  sin(q)   0
%     0     -sin(q)  cos(q)   0
%     0        0       0      1];
% 
% 
% N=size(P,1);
% P=[P ones(N,1)];
% 
% for i=1:N,
%     out(i,:)=R*P(i,:)';
% end
% 
% out=out(:,1:3);