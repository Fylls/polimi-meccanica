function [F,Fx]=slider4bar(X,th12,a1,a2,a4,a5,b1,c1)
%SLIDER4BAR Loop closure equations and Jacobian for the example in
%
%Copyright (c) Murat TAHTALI, UNSW@ADFA, 2007
th14=X(1);
th15=X(2);
S4=X(3);
S6=X(4);
F=[b1-a2*cos(th12)+a5*cos(th15)+S4*cos(th14)
    -c1-a2*sin(th12)+a5*sin(th15)+S4*sin(th14)
    b1-S6+a5*cos(th15)+a4*cos(th14)
    -a1-c1+a5*sin(th15)+a4*sin(th14)];

Fx=[-S4*sin(th14) -a5*sin(th15) cos(th14) 0
    S4*cos(th14)  a5*cos(th15)  sin(th14) 0
    -a4*sin(th14) -a5*sin(th15)     0    -1
    a4*cos(th14)  a5*cos(th15)      0     0];


