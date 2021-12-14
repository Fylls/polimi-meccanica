function velarrow(x,y,v,angle,vmax,scale,col)
WIDTH_HEAD=4*scale;
WIDTH_TAIL=2*scale;
LENGTH_HEAD=8*scale;


LENGTH=(v/vmax*scale);

COLOR=col;
arrow(x,y,WIDTH_HEAD,WIDTH_TAIL,LENGTH_HEAD,LENGTH,angle,COLOR);
