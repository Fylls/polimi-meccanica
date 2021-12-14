function [cc ] = hinge(obj, varargin)
%HINGE Generates a fixed revolute joint
%Usage HINGE(X0,Y0[,SCALE,COLOR,SILENT,ORDER,LABEL,LABELOFFSET[dx dy]])
%      HINGE(CC) regenerate an existing HINGE object
%SILENT =
%           0 generate only, don't display
%           1 generate and display
%COLOR = 'r','b','k','g',...
%
%Copyright (c) Murat TAHTALI, UNSW@ADFA, 2007

r=5;
b=r*2.5;
height=r*1.5;
N=8;



silent=1;
nargin_=nargin-1;
if nargin_==0
    cc=obj;
    silent=0;
    if isfield(cc,'show'),
        if cc.show==false;
            return
        end
    end
else
%%
    if isfield(obj,'v2')
       v2=obj.v2;
    else
        v2=false;
    end
%%
    x0=varargin{1};
    y0=varargin{2};


    if nargin_>2,
        scale=varargin{3};
    else
        scale=1;
    end

    if nargin_>3
        col=varargin{4};
    else
        col='k';
    end
    sln=5;
    if nargin_>4
        silent=varargin{5};
    else
        silent=0;
    end

    if nargin_>5
        order=varargin{6};
    else
        order=0;
    end
    
    if nargin_>6
        label=varargin{7};
    else
        label=[];
        if v2
           label=['hinge(' num2str(obj.index) ')']; 
        end
    end
    
    if nargin_>7
        labeloffset=varargin{8};
    else
        labeloffset=[0 0];
    end
    

    xylbl=labeloffset;
    
    xylbl(:,1)=xylbl(:,1)+x0;
    xylbl(:,2)=xylbl(:,2)+y0;
    
    

    r=r*scale;
    b=b*scale;
    b2=b/2;
    height=height*scale;


    c1=circle(x0,y0,r,256,col,1);
    c2=circle(x0,y0,r/4,256,col,1);

    %create the vertices as a horizontal link at the origin

    x=[r b2 -b2 -r]';
    y=[0 -height -height 0]';
    xy=[x y];

    %offset to the location:
    xy(:,1)=xy(:,1)+x0;
    xy(:,2)=xy(:,2)+y0;

    %create the hash lines
    dx=b/(N-1);
    dy=dx;
    hx0=x0-b2;
    hk=[0 0 -dx -dy];
    hk=hk+[hx0 y0-height hx0 y0-height];
    for i=1:N,
        hxy(i,:)=hk;
        hk=hk+[dx 0 dx 0];
    end

    cc.x0=x0;
    cc.y0=y0;
    cc.scale=scale;
    cc.height=height;
    cc.c1=c1;
    cc.c2=c2;
    cc.xy=xy;
    cc.hxy=hxy;
    cc.sln=sln;
    cc.order=order;
    cc.col=col;
    cc.xylbl=xylbl;
    cc.label=label;
    cc.labeloffset=labeloffset;

end

if silent==0,

    cc.h=fill(cc.xy(:,1),cc.xy(:,2),cc.col);
    cc.c1=circle(cc.c1);
    cc.c2=circle(cc.c2);
    for i=1:N
        pxy=[cc.hxy(i,1:2);cc.hxy(i,3:4)];
        plot(pxy(:,1),pxy(:,2),'k')
    end
    if ~isempty(cc.label),
        text(cc.xylbl(1,1),cc.xylbl(1,2),cc.label);
    end
end

