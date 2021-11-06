clear
close all

m=0.1;
M=10;
e=0.020;
a=0:0.001:4;
acca = [0.005 0.02 0.05 0.1 0.25 0.5 sqrt(2)/2];
f=figure;
ax1=subplot(211);
ax1.NextPlot='add';
ax2=subplot(212);
ax2.NextPlot='add';
for jj=1:length(acca)
    h=acca(jj);
    
    X(:,jj) = m*e/(m+M).*a.^2 ./ ( (1-a.^2)+1i*(2*h*a));
    
    plot(ax1,a,abs(X(:,jj))/(m*e/(m+M)),'Linewidth',2,'DisplayName',sprintf('h=%5.3f',h))
    plot(ax2,a,angle(X(:,jj)),'Linewidth',2,'DisplayName',sprintf('h=%5.3f',h))
end
axes(ax1)
plot(a,a*0+1,'k','DisplayName','1')
grid on
legend show
xlabel('a=\Omega/\omega')
ylabel('$\frac{|X_0|}{m\epsilon/(m+M)}$','FontSize',18,...
    'Interpreter','latex');

axes(ax2)
legend show
ylim([-pi 0])
ax2.YTick=-pi:pi/4:0;
ax2.YTickLabel=["-\pi","-3/2\pi","-\pi/2","-\pi/4","0"];
grid on
xlabel('a=\Omega/\omega')
ylabel('$\angle{X_0}$','FontSize',18,'Interpreter','latex');

linkaxes([ax1 ax2],'x')
xlim([0 4])



%% nel tempo
t=0:0.001:120;
h=0.01;


a=0.5;
om= 2*pi*1;%sqrt(k/(M+m));
OM = a*om;
X = m*e/(m+M).*a.^2 ./ ( (1-a.^2)+1i*(2*h*a));
phi = angle(X);
xp=abs(X)*sin(OM*t+phi);

x0=0;
dx0=0;
A= x0-abs(X)*sin(phi);
B= (+ A*h*om - abs(X)*om*cos(phi) + dx0)./(om*sqrt(1 - h^2));
xom = exp(-h*om*t).*( A*cos(om*sqrt(1-h^2)*t)+B*sin(om*sqrt(1-h^2)*t));


xtot = xp + xom;

figure
% plot(t,xp,'--','Linewidth',2)
plot(t,xtot,'Linewidth',2,'DisplayName',sprintf("a=%3.1f, h=%5.3f",a,h))
hold on




a   = 1;
OM  = a*om;
X   = m*e/(m+M).*a.^2 ./ ( (1-a.^2)+1i*(2*h*a));
phi = angle(X);
xp  = abs(X)*sin(OM*t+phi);

x0   = 0;
dx0 = 0;
A   = x0-abs(X)*sin(phi);
B   = (+ A*h*om - abs(X)*om*cos(phi) + dx0)./(om*sqrt(1 - h^2));
xom = exp(-h*om*t).*( A*cos(om*sqrt(1-h^2)*t)+B*sin(om*sqrt(1-h^2)*t));


xtot = xp + xom;
plot(t,xtot,'Linewidth',2,'DisplayName',sprintf("a=%3.1f, h=%5.3f",a,h))


a=4;
OM = a*om;
X = m*e/(m+M).*a.^2 ./ ( (1-a.^2)+1i*(2*h*a));
phi = angle(X);
xp=abs(X)*sin(OM*t+phi);

x0=0;
dx0=0;
A= x0-abs(X)*sin(phi);
B= (+ A*h*om - abs(X)*om*cos(phi) + dx0)./(om*sqrt(1 - h^2));
xom = exp(-h*om*t).*( A*cos(om*sqrt(1-h^2)*t)+B*sin(om*sqrt(1-h^2)*t));


xtot = xp + xom;
plot(t,xtot,'Linewidth',2,'DisplayName',sprintf("a=%3.1f, h=%5.3f",a,h))


legend show
xlabel('t [s]')
ylabel('x(t) [m]')