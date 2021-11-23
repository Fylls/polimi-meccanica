function [cc ] = link(obj, varargin)
%LINK Generates a straight link
%Usage LINK(COORDTYPE,X0,Y0,X1,Y1[,tickness,COLOR,SILENT,ORDER,LABEL,LABELOFFSET])
%      LINK(CC) regenerate an existing LINK object
%COORDTYPE =
%           'c' for cartesian coordinates
%           'r' for polar coordinates
%               X1 and Y1 become Length and Angle, respectively
%SILENT =
%           0 generate only, don't display
%           1 generate and display
%COLOR = 'r','b','k','g',...
%
%Copyright (c) Murat TAHTALI, UNSW@ADFA, 2007

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
    type=varargin{1};
    x0=varargin{2};
    y0=varargin{3};

    if type=='c',
        x1=varargin{4};
        y1=varargin{5};
        dx=(x1-x0);
        dy=(y1-y0);
        L=sqrt(dx^2+dy^2);
        ang=atan2(dy,dx);

    elseif type=='r',
        L=varargin{4};
        ang=varargin{5};
        x1=x0+L*cos(ang);
        y1=y0+L*sin(ang);
    end


    if nargin_>5
        t=varargin{6};
    else
        t=1;
    end
    if nargin_>6
        col=varargin{7};
    else
        col='b';
    end
    
    sln=8;
    if nargin_>7
        silent=varargin{8};
    else
        silent=0;
    end
    if nargin_>8
        order=varargin{9};
    else
        order=0;
    end

    if nargin_>9
        label=varargin{10};
    else
        label=[];
        if v2
           label=['link(' num2str(obj.index) ')']; 
        end
    end
    if nargin_>10
        labeloffset=varargin{11};
    else
        labeloffset=2;
    end
    r=t*1.4;

    c1=circle(x0,y0,r,256,col,1);
    c2=circle(x1,y1,r,256,col,1);

    %create the vertices as a horizontal link at the origin

    x=[0 L L 0]';
    y=[-t -t t t]';
    xy=[x y];
    xylbl=[L/2 labeloffset];
    

    xy=RotZ2d(xy,-ang);
    xylbl=RotZ2d(xylbl,-ang);
    xylbl(:,1)=xylbl(:,1)+x0;
    xylbl(:,2)=xylbl(:,2)+y0;

    xy(:,1)=xy(:,1)+x0;
    xy(:,2)=xy(:,2)+y0;

    cc.x0=x0;
    cc.y0=y0;
    cc.x1=x1;
    cc.y1=y1;
    cc.ang=ang;
    cc.xy=xy;
    cc.t=t;
    cc.col=col;
    cc.order=order;

    cc.c1=c1;
    cc.c2=c2;
    cc.sln=sln;
    cc.xylbl=xylbl;
    cc.label=label;
    cc.labeloffset=labeloffset;
end


if silent==0
    cc.h=fill(cc.xy(:,1),cc.xy(:,2),cc.col);
    cc.c1=circle(cc.c1);
    cc.c2=circle(cc.c2);
    if ~isempty(cc.label)
    text(cc.xylbl(1,1),cc.xylbl(1,2),cc.label);
    end
end

