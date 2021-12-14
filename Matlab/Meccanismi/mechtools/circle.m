function [ cc ] = circle( varargin )
%LINK Generates a circle
%Usage CIRCLE(X0,Y0,R,[N,COLOR,SILENT,ORDER])
%      LINK(CC) regenerate an existing CIRCLE object
%SILENT =
%           0 generate only, don't display
%           1 generate and display
%COLOR = 'r','b','k','g',...
%
%Copyright (c) Murat TAHTALI, UNSW@ADFA, 2007

silent=0;

if nargin>1
    x0=varargin{1};
    y0=varargin{2};
else
    cc=varargin{1};
    if isfield(cc,'show'),
        if cc.show==false;
            return
        end
    end
end

if nargin>2
    r=varargin{3};
    if nargin>3
        N=varargin{4};
    else
        N=64;
    end

    if nargin>4
        col=varargin{5};
    else
        col='r';
    end
    if nargin>5,
        silent=varargin{6};
    else
        silent=0;
    end

    NN=N/2;
    t = (1/N:1/NN:1)'*2*pi;
    x = x0+r*sin(t);
    y = y0+r*cos(t);


    cc.x0=x0;
    cc.y0=y0;
    cc.x=x;
    cc.y=y;
    cc.r=r;
    cc.N=N;
    cc.col=col;

end

if isfield(cc,'newx0'),
    if cc.newx0~=cc.x0,
        cc.x=cc.x+(cc.newx0-cc.x0);
        cc.x0=cc.newx0;
    end
    cc=rmfield(cc,'newx0');
end
if isfield(cc,'newy0'),
    if cc.newy0~=cc.y0,
        cc.y=cc.y+(cc.newy0-cc.y0);
        cc.y0=cc.newy0;
    end
    cc=rmfield(cc,'newy0');
end


if silent==0,
    h=fill(cc.x,cc.y,cc.col);
    cc.h=h;
end
