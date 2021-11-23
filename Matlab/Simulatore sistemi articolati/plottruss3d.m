function plottruss3d(nodes,elm,BCS,FORCES,nodesON,elementsON)
%Copyright Murat TAHTALI, 2003
%Australian Defence Force Academy
%School of Aerospace, Civil and Mechanical Engineering
%INTRODUCTION TO THE FINITE ELEMENT METHOD
%
%Function plottruss3d
%Plots in 3D the nodes and the elements a space truss structure
%Nodes and elements are numbered if nodesON=1 and elementsON=1,
%respectively.
% Version 2, 21/03/2007, included BCS and FORCES plotting. NOT compatible with
% previous calling syntax!!!!

N=size(elm,1);
hndl=figure

hold on
axis equal %([ MMIN MMAX MMIN MMAX MMIN MMAX]);
xlabel('x');
ylabel('y');
zlabel('z');
maxs=zeros(N,1);
mins=zeros(N,1);
for e=1:N,
    n1=elm(e,1);
    n2=elm(e,2);
    p=elm(e,3);
    x1=nodes(n1,1);
    y1=nodes(n1,2);
    z1=nodes(n1,3);
    x2=nodes(n2,1);
    y2=nodes(n2,2);
    z2=nodes(n2,3);
    maxs(e)=max([x1 y1 z1 x2 y2 z2]);
    mins(e)=min([x1 y1 z1 x2 y2 z2]);
    
    X=[x1;x2];
    Y=[y1;y2];
    Z=[z1;z2];
    cc=lineColor(p);
    %cc=strcat(cc,'o');
    plot3(X,Y,Z,cc)
    if elementsON==1,
        tx=(x1+x2)/2;
        ty=(y1+y2)/2;
        tz=(z1+z2)/2;
        s=num2str(e);
        text(tx,ty,tz,s,'EdgeColor',cc);    
    end
end


if nodesON==1,
n=size(nodes,1);
for i=1:n,
    x1=nodes(i,1);
    y1=nodes(i,2);
    z1=nodes(i,3);
    s=num2str(i);
    s=strcat('--- ',s);
    text(x1,y1,z1,s);  
    plot3(x1,y1,z1,'o')
    
    %check for constraints:
    for cs=1:3,
    if BCS(3*i-3+cs,2)~=0,
       pltconstr(x1,y1,z1,cs,0.05)
    end
    end
end
    
    
    
end


% XMIN=min(X);
% XMAX=max(X);
% YMIN=min(Y);
% YMAX=max(Y);
% ZMIN=min(Z);
% ZMAX=max(Z);
% MMAX=max([XMAX YMAX ZMAX]);
% MMIN=min([XMIN YMIN ZMIN]);
 MMIN=min(mins);
 MMAX=max(maxs);
 view(45,20)
axis equal %([ MMIN MMAX MMIN MMAX MMIN MMAX]);
xlabel('x');
ylabel('y');
zlabel('z');
hold off

function [c]=lineColor(p)
cc=[      {'b'}  %blue          
          {'g'}     %green        
          {'r'}     %red           
          {'c'}     %cyan          
          {'m'}     %magenta      
          {'y'}     %yellow      
          {'k'}    %black 
      ];
c=char(cc(p));


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


function [out]=RotZ(P,q)

%Rotates all points in P by and  angle q (deg) about the Z-axis

Rz=[ cos(q)  sin(q)  0  0
   -sin(q)  cos(q)  0  0
    0        0    1  0
    0        0    0  1];


N=size(P,1);
P=[P ones(N,1)];

for i=1:N,
    out(i,:)=Rz*P(i,:)';
end

out=out(:,1:3);

function [out]=RotY(P,q)

%Rotates all points in P by and  angle q (deg) about the Y-axis

R=[ cos(q)  0    -sin(q)   0
    0        1       0      0
    sin(q)   0    cos(q)    0
    0        0       0      1];


N=size(P,1);
P=[P ones(N,1)];

for i=1:N,
    out(i,:)=R*P(i,:)';
end

out=out(:,1:3);

function [out]=RotX(P,q)

%Rotates all points in P by and  angle q (deg) about the X-axis

R=[ 1        0       0      0
    0      cos(q)  sin(q)   0
    0     -sin(q)  cos(q)   0
    0        0       0      1];


N=size(P,1);
P=[P ones(N,1)];

for i=1:N,
    out(i,:)=R*P(i,:)';
end

out=out(:,1:3);

