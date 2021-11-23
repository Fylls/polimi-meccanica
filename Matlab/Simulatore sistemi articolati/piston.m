function [cc ] = piston(obj, varargin)
%PISTON Generates a piston
%Usage PISTON(COORDTYPE,X0,Y0,X1,Y1,THROW[,tickness,COLOR,SILENT,ORDER,LABEL,LABELOFFSET])
%      PISTON(CC) regenerate an existing PISTON object
%COORDTYPE =
%           'c' for cartesian coordinates
%           'r' for polar coordinates
%               X1 and Y1 become Length and Angle, respectively
%SILENT =
%           0 generate only, don't display
%           1 generate and display
%COLOR = 'r','b','k','g',...
%
%Copyright (c) Murat TAHTALI, UNSW@ADFA, 2007, 2019

silent=1;
nargin_=nargin-1
if nargin_==0
    cc=obj;
    silent=0;
    if isfield(cc,'show'),
        if cc.show==false;
            return
        end
    end
else
    
    if isfield(obj,'v2')
       v2=obj.v2;
    else
        v2=false;
    end
    
    
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
Throw=varargin{6};

    if nargin_>6
        t=varargin{7};
    else
        t=1;
    end
    if nargin_>7
        col=varargin{8};
    else
        col='b';
    end
    
    sln=9;
    if nargin_>8
        silent=varargin{9};
    else
        silent=0;
    end
    if nargin_>9
        order=varargin{10};
    else
        order=0;
    end

    if nargin_>10
        label=varargin{11};
    else
        label=[];
        if v2
           label=['piston(' num2str(obj.index) ')']; 
        end
    end
    if nargin_>11
        labeloffset=varargin{12};
    else
        labeloffset=-2;
    end
    r=t*1.4;

    c1=circle(x0,y0,r,256,col,1);
    c2=circle(x1,y1,r,256,col,1);

    %create the vertices as a horizontal link at the origin

    x=[0 Throw Throw 0]';
    y=[-t -t t t]'*1.5;
    xy=[x y];
    
    xtube=[Throw L L Throw]';
    ytube=[-t -t t t]';
    xytube=[xtube ytube];
    
    xylbl=[L/2 labeloffset];
    

    xy=RotZ2d(xy,-ang);
    xytube=RotZ2d(xytube,-ang);
    xylbl=RotZ2d(xylbl,-ang);
    xylbl(:,1)=xylbl(:,1)+x0;
    xylbl(:,2)=xylbl(:,2)+y0;

    xy(:,1)=xy(:,1)+x0;
    xy(:,2)=xy(:,2)+y0;
    
    xytube(:,1)=xytube(:,1)+x0;
    xytube(:,2)=xytube(:,2)+y0;

    cc.x0=x0;
    cc.y0=y0;
    cc.x1=x1;
    cc.y1=y1;
    cc.ang=ang;
    cc.xy=xy;
    cc.xytube=xytube;
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


if silent==0,
    cc.h=fill(cc.xy(:,1),cc.xy(:,2),cc.col);
    cc.h2=fill(cc.xytube(:,1),cc.xytube(:,2),cc.col);
    cc.c1=circle(cc.c1);
    cc.c2=circle(cc.c2);
    if ~isempty(cc.label),
    text(cc.xylbl(1,1),cc.xylbl(1,2),cc.label);
    end
end

