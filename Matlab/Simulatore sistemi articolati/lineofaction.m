function [cc ] = lineofaction( varargin)
%LINEOFACTION Summary of this function goes here
%   Detailed explanation goes here



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

% if nargin>2,
%     a=varargin{3};
% else
%     a=0;
% end

if nargin>2,
    L=varargin{3};
else
    L=500;
end

if nargin>3,
    ang=varargin{4};
else
    ang=0;
end


% if nargin>5,
%     scale=varargin{6};
% else
    scale=1;
% end

if nargin>4
    col=varargin{5};
else
   col='k'; 
end
sln=6;
if nargin>5
    silent=varargin{6};
else
    silent=0;
end
if nargin>6
    order=varargin{7};
else
    order=0;
end
%h=10*scale;
a=0;%*scale;
L2=L/2;
N=1;
%dL=L/(N-1);
% dy=h/sqrt(2);
% dL=dy;
% N=floor(L/dL)+1;
% 
% 
% 
% 
% %create the hash lines
% %dL=L/(N-1);
% dy=h/sqrt(2);
% dx=dy;
% hx0=x0-L2;
% hk=[0 0 -dx -dy];
% hk=hk+[hx0 y0-a hx0 y0-a];
% for i=1:N,
%     hxy(i,:)=hk;
%     hk=hk+[dL 0 dL 0];
% end
hxy(N,:)=[x0-L2 y0-a x0+L2 y0-a];

cc.x0=x0;
cc.y0=y0;
cc.scale=scale;
cc.a=a;
cc.L=L;
cc.ang=ang;
cc.order=order;
cc.N=N;
cc.hxy=hxy;
cc.col=col;
cc.sln=sln;

end




if silent==0,


for i=1:cc.N,
    pxy=[cc.hxy(i,1:2);cc.hxy(i,3:4)];
    %first translate to origin
    pxy=pxy-[cc.x0 cc.y0;cc.x0 cc.y0];
    pxy=RotZ2d(pxy,-cc.ang);
    %translate back
    pxy=pxy+[cc.x0 cc.y0;cc.x0 cc.y0];
plot(pxy(:,1),pxy(:,2),'k')
end
end

