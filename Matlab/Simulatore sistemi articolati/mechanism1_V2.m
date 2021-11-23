%MECHANISM1
%Example numerical solution to a double slider, one crank mechanism
%Change fixed link lengths and running parameters to demonstrate the behaviour
%of the mechanism
%
%Copyright (c) Murat TAHTALI, UNSW@ADFA, 2007, 2008, 2019
close all
clear all
%Define the fixed link lengths
a1=50;
a2=20;
a4=150;
a5=20;
a6=130;
b1=40;
c1=90;
w3=20;
h3=10;

%Define the initial layout, doesn't have to be exact
theta14=89*pi/180;
theta15=140*pi/180;
S4=a4/2;
S6=b1;

% theta14=1.5973
% theta15=3.6622
% S4=99.9824
% S6=18.6747


%Equation Tolerances
epsilonE=[0.001 0.001 .001 0.001]';
%Solution Tolerances
epsilonS=[0.001 0.001 .001 0.001]';


maxiter=100;
Nrevolutions=1;
theta12_start=0;
theta12_range=2*pi*Nrevolutions;
theta12_inc_deg=5;
dtheta12=theta12_inc_deg*pi/180;
Npoints=floor(360/theta12_inc_deg*Nrevolutions);


[symb,X]=initvariables('theta14',theta14,'theta15',theta15,'S4',S4,'S6',S6,'theta12',theta12_start);


clf

silent=0;
mech=[];
[mech,lastindex]=createmechobject(mech,'slidergrnd',1,-10,a1,-h3/1.9,100,0,1,'k',silent,1);
%#,x_center,y_center
[mech,lastindex]=createmechobject(mech,'hinge',1,0,0,1,'w',silent,0,'O1',[-2 -15]);
[mech,lastindex]=createmechobject(mech,'hinge',2,b1,-c1,1,'w',silent,0,'O2',[-2 10]);

[mech,lastindex]=createmechobject(mech,'link',1,'r',0,0,a2,'theta12',2,'b',silent,1);
[mech,lastindex]=createmechobject(mech,'link',2,'r',b1,-c1,a5,'theta15',2,'b',silent);
[mech,lastindex]=createmechobject(mech,'link',3,'r','link(2).x1','link(2).y1',a4,'theta14',2,'g',silent,5);

[mech,lastindex]=createmechobject(mech,'piston',1,'c','link(3).x1','link(3).y1',100,'link(3).y1',70,1,'b',silent);

[mech,lastindex]=createmechobject(mech,'block',1,'link(1).x1','link(1).y1',w3,h3,'theta14','r',silent,6);
[mech,lastindex]=createmechobject(mech,'block',2,'link(3).x1','link(3).y1',w3,h3,0,'r',silent,0);

axis([-150 120 -120 100]);
%axis square
axis equal
%Store AXIS settings to be used later in each refresh
ax=axis;
drawnow %force the graphics to draw now
%%
for i=0:Npoints,
    theta12=theta12_start+i*dtheta12;
    th12(i+1)=theta12;
    [X,k]=solvemech(@slider4bar,X,epsilonE,epsilonS,maxiter,[],theta12,a1,a2,a4,a5,b1,c1);
    %check if the solver converged (if k is non zero)
    if k>0, %regenerate the mechanism
        theta14=X(1);
        th14(i+1)=theta14;
        theta15=X(2);
        S4=X(3);
        s4(i+1)=S4;
        S6=X(4);
        mech=regenmech(mech,symb,X);
        axis(ax) %set the original axis so that the figure is not jumpy due to limits changing
        drawnow %force the graphics to draw now
    end
end

figure
subplot(2,1,1)
plot(th12*180/pi,th14)
subplot(2,1,2)
plot(th12*180/pi,s4)

