function [mech,lastindex]=createmechobject(varargin)
v2=false;

if isstruct(varargin{1})
    v2=true;
    mech=varargin{1};
else
    if isempty(varargin{1})
        v2=true;
        mech=[];
    end
end

if v2
    argin_offset1=1;
    argin_offset2=2;
    index=varargin{3};
    mobj.index=index;
else
    argin_offset1=0;
    argin_offset2=0;
end

tp=varargin{1+argin_offset1};
n=nargin;
mobj.type=tp;
mobj.v2=v2;


args=varargin(1+argin_offset1:n);


mobj.args{1}=varargin{1+argin_offset1};
mobj.args(2:n-argin_offset2)=varargin(2+argin_offset2:n);


mobj.cc=[];

switch upper(tp)
    case 'ARROW'
        sln=9;
    case 'LINK'
        sln=8;
    case 'HINGE'
        sln=5;
    case 'PISTON'
        sln=9;
    case 'BLOCK'
        sln=7;
    case 'SLIDERGRND'
        sln=8;
    case 'LINEOFACTION'
        sln=6;
end

if n<sln+1+argin_offset2,
            mobj.silent=0;
else
            mobj.silent=varargin{sln+1+argin_offset2};
end
if n>sln+1+argin_offset2,
            mobj.order=varargin{sln+2+argin_offset2};
        else
            mobj.order=0;
end 
mobj.sln=sln;

if v2
mech=setfield(mech,tp,{index},mobj);
lastindex=index;
else
    mech=mobj;
end
