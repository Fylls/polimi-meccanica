%%
clear all
a1=50
a2=20
a4=150
a5=20
a6=60
b1=40
c1=90

w3=20
h3=10
theta14=89*pi/180
theta15=140*pi/180
S4=a4/2
S6=b1

%initial guess for unknowns:

X0(1)=theta14;
X0(2)=theta15;
X0(3)=S4;
X0(4)=S6;
X0=X0';

%Equation Tolerances
epsilonE=[0.001 0.001 .001 0.001]'
%Solution Tolerances
epsilonS=[0.001 0.001 .001 0.001]'


maxiter=100
Nrevolutions=1
theta12_start=0
theta12_range=2*pi*Nrevolutions
theta12_inc_deg=5
dtheta12=theta12_inc_deg*pi/180;
Npoints=floor(360/theta12_inc_deg*Nrevolutions)

clf
% axis square

% cc=circle(20,40,30,256,'b');
% 
silent=1
hold on

mech.hinge(1)=hinge(0,0,1,'w',silent);
mech.hinge(2)=hinge(b1,-c1,1,'w',silent);
mech.link(1)=link('r',0,0,a2,theta12_start,2,'b',silent);
mech.link(2)=link('r',b1,-c1,a5,theta15,2,'b',silent);
mech.link(3)=link('r',mech.link(2).x1,mech.link(2).y1,a4,theta14,2,'g',silent);
mech.link(4)=link('r',mech.link(3).x1,mech.link(3).y1,a6,0,2,'b',silent);
mech.block(1)=block(mech.link(1).x1,mech.link(1).y1,w3,h3,theta14,'r',silent);

mech=regenmech(mech);
axis([-60 120 -120 80])
%axis square
axis equal

ax=axis;
 drawnow
%%
for i=0:Npoints,
    theta12=theta12_start+i*dtheta12;
    [X,k]=solvemech(@slider4bar,X0,epsilonE,epsilonS,maxiter,[],theta12,a1,a2,a4,a5,b1,c1);
    %check if the solver converged (if k is non zero)
    if k>0, %regenerate the mechanism
        theta14=X(1);
        theta15=X(2);
        S4=X(3);
        S6=X(4);
        clear mech
        mech.hinge(1)=hinge(0,0,1,'w',silent);
        mech.hinge(2)=hinge(b1,-c1,1,'w',silent);
        mech.link(1)=link('r',0,0,a2,theta12,2,'b',silent,7);
        mech.link(2)=link('r',b1,-c1,a5,theta15,2,'b',silent);
        mech.link(3)=link('r',mech.link(2).x1,mech.link(2).y1,a4,theta14,2,'g',silent,5);
        mech.link(4)=link('r',mech.link(3).x1,mech.link(3).y1,a6,0,2,'b',silent);
        mech.block(1)=block(mech.link(1).x1,mech.link(1).y1,w3,h3,theta14,'r',silent,6);
        cla reset
        hold on
        mech=regenmech(mech);
        axis(ax)
%        axis equal
        drawnow
    end    
end






return
ll=link1(20,40,150,70,2,'b',1);
ll.show=1;
ll=link1(ll);
hh=hinge(20,40,1,'w');
bb=block(46,46,10,30,ll.ang,'g')
axis square
axis equal
return
cc.col='g';
circle(cc)

dx=0;
dy=20;
for i=1:10
    pause(0.2)
    cc.newx0=cc.x0+dx;
    cc.newy0=cc.y0+dy;
    cc=circle(cc);
%     axis square
axis equal
end
