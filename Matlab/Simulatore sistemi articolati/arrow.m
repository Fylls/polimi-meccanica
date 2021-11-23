function [cc ] = arrow( varargin)
%ARROW Generates an arrow at a point with given angle an length
%Usage ARROW(X0,Y0,WIDTH_HEAD,WIDTH_TAIL,LENGTH_HEAD,LENGTH,ANGLE[,COLOR,SILENT,ORDER])
%      ARROW(CC) regenerate an existing BLOCK object
%      If L>0, then X0,Y0 is the tail of the arrow
%      If L<0, then X0,Y0 is the tip of the arrow   
%SILENT =
%           1 generate only, don't display
%           0 generate and display
%COLOR = 'r','b','k','g',...
%
%Copyright (c) Murat TAHTALI, UNSW@ADFA, 2007
silent=1;
if nargin==1
    cc=varargin{1};
    silent=0;
    if isfield(cc,'show'),
        if cc.show==false;
            return
        end
    end
else

    x0=varargin{1};
    y0=varargin{2};
    width_head=varargin{3};
    width_tail=varargin{4};
    L_head=varargin{5};
    
    L=varargin{6};
    tail=sign(L);
    L=abs(L);
    ang=varargin{7};
 
    w2=width_tail/2;
    wh2=width_head/2;
    L1=L-L_head;
    
    

    if nargin>7
        col=varargin{8};
    else
        col='b';
    end
    sln=9;
    if nargin>8
        silent=varargin{9};
    else
        silent=0;
    end
    if nargin>9
        order=varargin{10};
    else
        order=0;
    end

    %create the vertices as a horizontal link at the origin

    x=[0 L1 L1 L L1 L1 0]';
    if tail<0,
        x=x-L;
    end
    y=[-w2 -w2 -wh2 0 wh2 w2 w2]';
    xy=[x y];

    xy=RotZ2d(xy,-ang);

    xy(:,1)=xy(:,1)+x0;
    xy(:,2)=xy(:,2)+y0;

    cc.x0=x0;
    cc.y0=y0;
    cc.width_head=width_head;
    cc.width_tail=width_tail;
    cc.length_head=L_head;
    cc.length=L;
    
    cc.ang=ang;
    cc.xy=xy;
    cc.col=col;
    cc.sln=sln;
    cc.order=order;

end

if silent==0,
    cc.h=fill(cc.xy(:,1),cc.xy(:,2),cc.col);

end

