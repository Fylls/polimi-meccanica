function [cc ] = block(obj, varargin)
%BLOCK Generates a block at a point with given angle
%Usage BLOCK(X0,Y0,WIDTH,HEIGHT,ANGLE[,COLOR,SILENT,ORDER,LABEL,LABELOFFSET])
%      BLOCK(CC) regenerate an existing BLOCK object
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
    x0=varargin{1};
    y0=varargin{2};
    width=varargin{3};
    height=varargin{4};
    ang=varargin{5};
    w2=width/2;
    h2=height/2;

    if nargin_>5
        col=varargin{6};
    else
        col='b';
    end
    sln=7;
    if nargin_>6
        silent=varargin{7};
    else
        silent=0;
    end
    if nargin_>7
        order=varargin{8};
    else
        order=0;
    end

    if nargin_>8
        label=varargin{9};
    else
        label=[];
        if v2
           label=['block(' num2str(obj.index) ')']; 
        end
    end
    if nargin_>9
        labeloffset=varargin{10};
    else
        labeloffset=2;
    end
    
    
    
    %create the vertices as a horizontal link at the origin

    x=[-w2 w2 w2 -w2]';
    y=[-h2 -h2 h2 h2]';
    xy=[x y];
    xylbl=[0 labeloffset];
    
    xylbl=RotZ2d(xylbl,-ang);
    xylbl(:,1)=xylbl(:,1)+x0;
    xylbl(:,2)=xylbl(:,2)+y0;
    
    
    xy=RotZ2d(xy,-ang);

    xy(:,1)=xy(:,1)+x0;
    xy(:,2)=xy(:,2)+y0;

    cc.x0=x0;
    cc.y0=y0;
    cc.height=height;
    cc.width=width;
    cc.ang=ang;
    cc.xy=xy;
    cc.col=col;
    cc.sln=sln;
    cc.xylbl=xylbl;
    cc.label=label;
    cc.order=order;
end

if silent==0,
    cc.h=fill(cc.xy(:,1),cc.xy(:,2),cc.col);
    if ~isempty(cc.label)
    text(cc.xylbl(1,1),cc.xylbl(1,2),cc.label);
    end
end

