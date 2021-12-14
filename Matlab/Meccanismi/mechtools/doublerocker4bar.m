function [F,Fx]=doublerocker4bar(X,th13,a1,a2,a3,a4)
%DOUBLEROCKER4BAR Loop closure equations and Jacobian for the example in
% "Iterative Solution of the Loop Closure Equations" in the lecture handouts
% for ZACM2440 Mechanics of Machines
%
%Copyright (c) Murat TAHTALI, UNSW@ADFA, 2007
th12=X(1);
th14=X(2);

F=[a2*cos(th12)-a1-a4*cos(th14)+a3*cos(th13)
   a2*sin(th12)-a4*sin(th14)+a3*sin(th13)];   



Fx=[-a2*sin(th12) a4*sin(th14)
    a2*cos(th12)  -a4*cos(th14)];



