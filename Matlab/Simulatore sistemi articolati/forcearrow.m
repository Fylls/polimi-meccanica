function forcearrow(x,y,Fmax,F,angle,scale,col,WIDTH_HEAD,WIDTH_TAIL,LENGTH_HEAD)
if nargin<5,
angle=0;
end
if nargin<6,
    scale=1;
end

if nargin<7,
    col='r';
end

if nargin<8,
WIDTH_HEAD=0.06*scale;
end
if nargin<9,
WIDTH_TAIL=0.02*scale;
end

if nargin<10,
LENGTH_HEAD=0.1*scale;
end

LENGTH=(F/Fmax*scale);

COLOR=col;
arrow(x,y,WIDTH_HEAD,WIDTH_TAIL,LENGTH_HEAD,LENGTH,angle,COLOR);
