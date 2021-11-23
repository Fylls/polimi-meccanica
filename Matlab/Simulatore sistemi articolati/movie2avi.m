function movie2avi(Frm,fname,fps)
Npoints=length(Frm);
v = VideoWriter(fname);
v.FrameRate=fps;
open(v);

for k = 1:Npoints
   writeVideo(v,Frm(k));
end

close(v);