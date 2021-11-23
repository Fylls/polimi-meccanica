function [V]=crossproduct(A,B)
%CROSSPRODUCT(A,B)
%Input A=[Ax Ay Az] and B=[Bx By Bz]
%A and B can be matrices of M row vectors
[Ma,Na]=size(A);
Ax=A(:,1);
Ay=A(:,2);
if Na<3,
    Az(Ma,1)=0;
else
    Az=A(:,3);
end
[Mb,Nb]=size(B);
Bx=B(:,1);
By=B(:,2);
if Nb<3,
    Bz(Mb,1)=0;
else
    Bz=B(:,3);
end




Vx=Ay.*Bz-Az.*By;
Vy=Az.*Bx-Ax.*Bz;
Vz=Ax.*By-Ay.*Bx;

V=[Vx Vy Vz];