function [ mech ] = regenmech( varargin )
%REGENMECH Regenerates a mechanism contained in a structure
%Usage REGENMECH(MECHSTRUCT)
%
%Copyright (c) Murat TAHTALI, UNSW@ADFA, 2007


mech=varargin{1};
symb=varargin{2};
X=varargin{3};
if nargin>3,
insert=varargin{4};
else
    insert=false;
end

%make all symbolic variables avalable:

% N=length(X);
% 
% for i=1:N,
%    
%     extxt=[symb{i} '=X(' num2str(i) ')'];
%     eval(extxt);
% end


if ~insert,
    cla reset
end

hold on
%check how many hinges:
if isfield(mech,'hinge'),
    mech.hingeN=length(mech.hinge);
else
    mech.hingeN=0;
end

%check how many links:
if isfield(mech,'link'),
    mech.linkN=length(mech.link);
else
    mech.linkN=0;
end

%check how many pistons:
if isfield(mech,'piston'),
    mech.pistonN=length(mech.piston);
else
    mech.pistonN=0;
end


%check how many blocks:
if isfield(mech,'block'),
    mech.blockN=length(mech.block);
else
    mech.blockN=0;
end

%check how many slidergrounds:
if isfield(mech,'slidergrnd'),
    mech.slidergrndN=length(mech.slidergrnd);
else
    mech.slidergrndN=0;
end

%check how many arrows:
if isfield(mech,'arrow'),
    mech.arrowN=length(mech.arrow);
else
    mech.arrowN=0;
end


%check how many lineofactions:
if isfield(mech,'lineofaction'),
    mech.lineofactionN=length(mech.lineofaction);
else
    mech.lineofactionN=0;
end


%shoestring all objects
Nall=mech.blockN+mech.linkN+mech.hingeN+mech.slidergrndN+mech.arrowN+mech.lineofactionN+mech.pistonN;

c=1;
Nitem=[];
%hinges:
for i=1:mech.hingeN
    item(c).obj=mech.hinge(i);
    item(c).type='hinge';
    item(c).index=i;
    
    nargs=newargs(Nitem,symb,X,item(c).obj);
    Nitem.hinge(i)=hinge(item(c).obj,nargs{:});
    c=c+1;
end

%links:

for i=1:mech.linkN
    item(c).obj=mech.link(i);
    item(c).type='link';
    item(c).index=i;
    nargs=newargs(Nitem,symb,X,item(c).obj);
    Nitem.link(i)=link(item(c).obj,nargs{:});
    c=c+1;
end

%pistons:

for i=1:mech.pistonN
    item(c).obj=mech.piston(i);
    item(c).type='piston';
    item(c).index=i;
    nargs=newargs(Nitem,symb,X,item(c).obj);
    Nitem.piston(i)=piston(item(c).obj,nargs{:});
    c=c+1;
end


%blocks:

for i=1:mech.blockN
    item(c).obj=mech.block(i);
    item(c).type='block';
    item(c).index=i;
    nargs=newargs(Nitem,symb,X,item(c).obj);
    Nitem.block(i)=block(item(c).obj,nargs{:});
    c=c+1;
end

%slidergrounds:

for i=1:mech.slidergrndN
    item(c).obj=mech.slidergrnd(i);
    item(c).type='slidergrnd';
    item(c).index=i;
    nargs=newargs(Nitem,symb,X,item(c).obj);
    Nitem.slidergrnd(i)=slidergrnd(nargs{:});
    c=c+1;
end

%arrows:

for i=1:mech.arrowN
    item(c).obj=mech.arrow(i);
    item(c).type='arrow';
    item(c).index=i;
    nargs=newargs(Nitem,symb,X,item(c).obj);
    Nitem.arrow(i)=arrow(nargs{:});
    c=c+1;
end

for i=1:mech.lineofactionN
    item(c).obj=mech.lineofaction(i);
    item(c).type='lineofaction';
    item(c).index=i;
    nargs=newargs(Nitem,symb,X,item(c).obj);
    Nitem.lineofaction(i)=lineofaction(nargs{:});
    c=c+1;
end


%collect order info
for i=1:Nall
    order(i,:)=[item(i).obj.order i];
end

[order1,IX]=sort(order,1);

%regenerate in order

for i=1:Nall

    obj=item(IX(i,1)).obj;
    index=item(IX(i,1)).index;
if obj.silent==0,    
    switch item(IX(i,1)).type
        case 'hinge'         
         cc=hinge(Nitem.hinge(index));
         mech.hinge(index).cc=cc;
        case 'link'
         cc=link(Nitem.link(index));
         mech.link(index).cc=cc;
        case 'piston'
         cc=piston(Nitem.piston(index));
         mech.piston(index).cc=cc;
        case 'block'
         cc=block(Nitem.block(index));
         mech.block(index).cc=cc;
        case 'slidergrnd'
         cc=slidergrnd(Nitem.slidergrnd(index));
         mech.slidergrnd(index).cc=cc;
        case 'arrow'
         cc=arrow(Nitem.arrow(index));
         mech.arrow(index).cc=cc;
        case 'lineofaction'
         cc=lineofaction(Nitem.lineofaction(index));
         mech.lineofaction(index).cc=cc;   
    end
end
end
axis equal
hold off

function v=subval(item,symb,X,v)



%check if v is empty
if isempty(v)
    return
end

%check if v is numeric
if isnumeric(v)
    return
end




%check if v is a string
if ischar(v)
N=length(symb);

% for i=1:N,
%     
%     if strcmp(v,symb{i}),
%         v=X(i);
%         return
%     end
% end
v=subsymbols(v,symb,item);

try
   %v=eval(['item.' v]);
   v=eval(v);
catch ME
   v=v;    
end
return

%check expression inside the items
f1=lparse(v,'(',1);
f2=rparse(v,'.',1);
ind=str2num(lparse(rparse(v,'(',1),')',1));
if isfield(item,f1)
    obj=getfield(item,f1);
    if isnumeric(ind)
       v=getfield(obj(ind),f2);
    end
end



end

function [nargs]=newargs(item,symb,X,obj)
args=obj.args;
N=length(args);
nargs{N-1}=[];

%only sub variables where they apply on each item:
tp=upper(args{1});
switch tp
    case 'ARROW'
        i0=1;
        i1=7;
    case 'LINK'
        i0=2;
        i1=5;
    case 'HINGE'
        i0=1;
        i1=2;
    case 'PISTON'
        i0=2;
        i1=6;
    case 'BLOCK'
        i0=1;
        i1=5;
    case 'SLIDERGRND'
        i0=1;
        i1=7;
    case 'LINEOFACTION'
        i0=1;
        i1=5;
end


for i=1:N-1
    if i>=i0&& i<=i1
    v=subval(item,symb,X,args{i+1});
    nargs{i}=v;
    else
        nargs{i}=args{i+1};
    end
end
sln=obj.sln;
nargs{sln}=1;
nargs{sln+1}=obj.order;






