function [cc ] = arrow3d( varargin)
%ARROW Generates an arrow at a point with given angle an length
%Usage ARROW(X0,Y0,Z0,WIDTH_HEAD,WIDTH_TAIL,LENGTH_HEAD,LENGTH,VECTOR,COLOR)
%      If L>0, then X0,Y0,Z0 is the tail of the arrow
%      If L<0, then X0,Y0,Z0 is the tip of the arrow   
%
%COLOR = 'r','b','k','g',...
%
%Copyright (c) Murat TAHTALI, UNSW@ADFA, 2007


    x0=varargin{1};
    y0=varargin{2};
    z0=varargin{3};
    width_head=varargin{4};
    width_tail=varargin{5};
    L_head=varargin{6};
    
    L=varargin{7};
    tail=sign(L);
    L=abs(L);
    vec=varargin{8};
    dx=vec(1);
    dy=vec(2);
    dz=vec(3);
    [Theta,Omega]=vec2rot(dx,dy,dz);
    
    w2=width_tail/2;
    wh2=width_head/2;
    L1=L-L_head;
    
    

    if nargin>8
        CV=varargin{9};
    else
        CV=1;
    end


    %create the vertices as a horizontal link at the origin

    x=[0 L1 L1 L]';% L1 L1 0]';
    if tail<0,
        x=x-L;
    end
    y=[-w2 -w2 -wh2 0]';% wh2 w2 w2]';
    z=[0 0 0 0]';
   % u=[1 1 1 1]';
    xyz=[x y z];
    [X,Y,Z]=revolve(xyz,'x',pi*2,36);
    [m,n]=size(X);
    
    XYZ=[X(:) Y(:) Z(:)];
    XYZ=RotY(XYZ,-Omega);

    XYZ=RotZ(XYZ,Theta);
    XYZ=TransXYZ(XYZ,[x0 y0 z0]);
    X=reshape(XYZ(:,1),m,n);
    Y=reshape(XYZ(:,2),m,n);
    Z=reshape(XYZ(:,3),m,n);
    c=ones(m,n)*CV;
    surface(X,Y,Z,c,'EdgeColor','none')



