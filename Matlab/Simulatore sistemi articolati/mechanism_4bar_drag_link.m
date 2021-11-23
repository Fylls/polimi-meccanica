%MECHANISM2
%Example numerical solution to a double slider, one crank mechanism
%Change fixed link lengths and running parameters to demonstrate the behaviour
%of the mechanism
%
%Copyright (c) Murat TAHTALI, UNSW@ADFA, 2007, 2008
close all
clear all
%Define the fixed link lengths


a1=20; %fixed link
a2=30; %driving crank
a3=30; %coupler
a4=25; %driven crank


labeloffset=-2;
Ls=[a1 a2 a3 a4];
[Lsort,Lsortidx]=sort(Ls)
Lmax=Lsort(4);
Lmin=Lsort(1);
La=Lsort(2);
Lb=Lsort(3);
labelsorgidx=[Lsortidx(4) Lsortidx(1) Lsortidx(2) Lsortidx(3)];
LsLabels={'L0' 'L1' 'L2' 'L3'};
labels={[LsLabels{labelsorgidx(1)} '=Lmax=' num2str(Lmax)] [LsLabels{labelsorgidx(2)} '=Lmin=' num2str(Lmin)] [LsLabels{labelsorgidx(3)} '=La=' num2str(La)] [LsLabels{labelsorgidx(4)} '=Lb=' num2str(Lb)]};
[lblsort,lblidx]=sort(labelsorgidx);
isgrashof=Lmax+Lmin <=La+Lb


%Define the initial layout, doesn't have to be exact
theta13=pi/6;
theta14=pi/2;


%Equation Tolerances
epsilonE=[0.001 0.001]';
%Solution Tolerances
epsilonS=[0.001 0.001]';


maxiter=100;
Nrevolutions=1;
theta12_start=pi/2;
theta12_range=2*pi*Nrevolutions;
theta12_inc_deg=5;
dtheta12=theta12_inc_deg*pi/180;
Npoints=floor(360/theta12_inc_deg*Nrevolutions);


[symb,X]=initvariables('theta13',theta13,'theta14',theta14,'theta12',theta12_start);


clf

silent=0;

mech.hinge(1)=createmechobject('hinge',0,0,1/3,'w',silent,1);
mech.hinge(2)=createmechobject('hinge',a1,0,1/3,'w',silent,1);
mech.link(1)=createmechobject('link','r',0,0,a2,'theta12',1,'b',silent,2,labels{lblidx(2)});
mech.link(2)=createmechobject('link','r','link(1).x1','link(1).y1',a3,'theta13',1,'g',silent,1,labels{lblidx(3)});
mech.link(3)=createmechobject('link','r',a1,0,a4,'theta14',1,'r',silent,0,labels{lblidx(4)});
mech.link(4)=createmechobject('link','c',0,0,a1,0,1,'y',silent,1,labels{lblidx(1)});
figure('units','normalized','outerposition',[0 0 1 1])



axis([-35 55 -35 35])
ax=axis;
%axis square
axis equal
%Store AXIS settings to be used later in each refresh

drawnow %force the graphics to draw now
%%
for i=0:Npoints,
    theta12=theta12_start+i*dtheta12;
    th12(i+1)=theta12;
    [X,k]=solvemech(@slider4bar2,X,epsilonE,epsilonS,maxiter,[],theta12,a1,a2,a3,a4);
    %check if the solver converged (if k is non zero)
    if k>0, %regenerate the mechanism
        theta13=X(1);
        th13(i+1)=theta13;
        theta14=X(2);
        th14(i+1)=theta14;
        mech=regenmech(mech,symb,X);
        axis(ax) %set the original axis so that the figure is not jumpy due to limits changing
        drawnow %force the graphics to draw now
        Frm(i+1)=getframe;
    end
end

return
movie2avi(Frm,'drag_link.avi',15)

