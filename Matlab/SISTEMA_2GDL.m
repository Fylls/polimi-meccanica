%Test3
%potremmo mettere anche che le persone possono scegliere il tspan, cosi
%possono strutturare la cosa in base ai loro bisogni


[step,M1,M2,k1,k2,k3,c1,c2,c3,x1_0,x2_0,v1_0,v2_0]=data_input();%definizione costanti
tspan=[0 20];%limite di tempo

M = eye(4);
M(2,2) = M1;
M(4,4) = M2;
y0=[x1_0 v1_0 x2_0 v2_0]; %definizione dello stato(posizione e velocità 1 e 2)

[t,y]=ode45(@(t,y)odefcn(y,M,k1,k2,k3,c1,c2,c3),tspan,y0); %integratore 

a1 = (1/M1)*((-k1-k2)*y(:,1)+(-c1-c2)*y(:,2)+k2*y(:,3)+c2*y(:,4));  %cosi ottengo tutte le derivate(comprese le accelerazioni)
a2 = (1/M2)*(k2*y(:,1)+c2*y(:,2)+(-k2-k3)*y(:,3)+(-c2-c3)*y(:,4));

cart_width = 4;
n_t = numel(t);  %numero di campionamenti


T_pause = step*tspan(2)/n_t;


scrsz = get(groot,'ScreenSize'); %da le dimensioni dello schermo

figure('Position',[50 50 scrsz(3)*.75 scrsz(4)*.75]); 

distance = max(y(:,1))-min(y(:,3))+2*cart_width;    %minimum distance to avoid collision


limits = [min(min(y(:,[1 3])))-2 max(max(y(:,[1 3])))+distance+2];
wall = [limits(1) limits(1) limits(2) limits(2)];
limit_sx = limits(1);
limit_dx = limits (2);
damper_y_position = 1;

flag = 0;





%wheels definition

Wrad = 0:.02:2*pi;
Wx = 0.25*cos(Wrad);
Wy = 0.25*sin(Wrad);

%cart definition
%renderla dinamica
width_vector = [-cart_width/2 cart_width/2 cart_width/2 -cart_width/2];
cart_height = 3;
height_vector = [0 0 cart_height cart_height];



subplot(2,1,2)
plot(wall,[5 0 0 5],'k','LineWidth',4) % ground and wall.
  
for ii = [step+1:step:n_t]
    if flag 
        delete([w1_1,w1_2,cart1,w2_1,w2_2,cart2,dot_plot,dot_plot2, dot_3, dot_4,...
            spring_1, spring_2, spring_3]);
        delete([damper, damper_2, damper_3]);
    end
    %plot
    subplot(2,1,1)
    hold on
    ylim(limits); %così il grafico è sempre a posto
    xlim([t(ii)-5 t(ii)]);
    x_1 = y(ii,1);
    x_2 = y(ii,3) + distance; 
    plot(t(ii-step:ii,:),y(ii-step:ii,1),'r')
    plot(t(ii-step:ii,:),y(ii-step:ii,3)+distance,'b')
    dot_plot = plot(t(ii), x_1, 'r.','MarkerSize',20);
    dot_plot2 = plot(t(ii), x_2, 'b.','MarkerSize',20);
    
    view([90 90])
    
    
    subplot(2,1,2)
        %TODO these xlim must be as the ylim at the moment
    hold on
    
    dot_3 = plot(x_1, 2,'r.','MarkerSize',30); %puntini in mezzo ai carrelli
    dot_4 = plot(x_2, 2,'b.','MarkerSize',30); 
    
    xlim(limits)  
    hold on
    w1_1 = patch(Wx+x_1-1.8, Wy+.25,'r'); % wheel
    w1_2 = patch(Wx+x_1+1.8, Wy+.25,'r'); 
    cart1 = patch(x_1+ width_vector ,0.5 + height_vector,'g'); %TODO make it in proportions
    
    w2_1 = patch(Wx+x_2-1.8, Wy+.25,'b'); % wheel
    w2_2 = patch(Wx+x_2+1.8, Wy+.25,'b');     
    cart2 = patch(x_2 + width_vector ,0.5 + height_vector,'y');
    alpha(0.3)
    hold on
    
    spring_1 = plot([limits(1), limits(1)+1, limits(1)+1 :( (x_1-cart_width-limits(1)- 1) /9) :x_1-cart_width, x_1-4, x_1-cart_width/2],...
       2+1+[0 0 0 .5 -.5 .5 -.5 .5 -.5 .5 -.5 0 0 0],'r','LineWidth',2); % spring
    
    spring_2 = plot([x_1 + cart_width/2, x_1+cart_width, x_1+cart_width :( (x_2-x_1-2*cart_width) /20) :x_2-cart_width, x_2-cart_width, x_2-cart_width/2],...
        2+1+[0 0 0 .5 -.5 .5 -.5 .5 -.5 .5 -.5 .5 -.5 .5 -.5 .5 -.5 .5 -.5 .5 -.5 .5 0 0 0],'r','LineWidth',2);
    
    spring_3 = plot([x_2 + cart_width/2, x_2+cart_width, x_2+cart_width :( (limits(2)-1-x_2-cart_width) /9) :limits(2)-1, limits(2)-1, limits(2)],...
        2+1+[0 0 0 .5 -.5 .5 -.5 .5 -.5 .5 -.5 0 0 0],'r','LineWidth',2);
    
    
    
    %dampers
    m1_sx = x_1 - cart_width/2;
    m1_dx = x_1 + cart_width/2;
    m2_sx = x_2 - cart_width/2;
    m2_dx = x_2 + cart_width/2;
    
    damper = plot (limit_sx+[0, (m1_sx - limit_sx)/2] , damper_y_position+[0 0],'b',... %linea di mezzeria
        limit_sx+[(m1_sx - limit_sx)/2,(m1_sx - limit_sx)/2], damper_y_position+[-.3 .3],'b',...    %linea verticale
        limit_sx+[(m1_sx - limit_sx)/2-1, (m1_sx - limit_sx)/2+1, (m1_sx - limit_sx)/2+1, (m1_sx - limit_sx)/2-1],...
        damper_y_position+[.5 .5 -.5 -.5],'b',...   %linea verticale
        m1_sx-[(m1_sx-limit_sx)/2-1,0], damper_y_position + [0 0]','b','LineWidth',2);
    
    damper_2 =  plot (m1_dx+[0, (m2_sx - m1_dx)/2] , damper_y_position+[0 0],'b',...  %linea di mezzeria
         m1_dx+[(m2_sx - m1_dx)/2,(m2_sx - m1_dx)/2], damper_y_position+[-.3 .3],'b', ...    %linea verticale
         m1_dx+[(m2_sx - m1_dx)/2-1, (m2_sx - m1_dx)/2+1, (m2_sx - m1_dx)/2+1, (m2_sx - m1_dx)/2-1],...
         damper_y_position+[.5 .5 -.5 -.5],'b',...   %linea verticale
         m2_sx-[(m2_sx - m1_dx)/2-1,0], damper_y_position + [0 0]','b','LineWidth',2);  
     
    damper_3 = plot (m2_dx+[0, (limit_dx - m2_dx)/2] , damper_y_position+[0 0],'b',... %linea di mezzeria
        m2_dx+[(limit_dx - m2_dx)/2,(limit_dx - m2_dx)/2], damper_y_position+[-.3 .3],'b',...    %linea verticale
        m2_dx+[(limit_dx - m2_dx)/2-1, (limit_dx - m2_dx)/2+1, (limit_dx - m2_dx)/2+1, (limit_dx - m2_dx)/2-1],...
        damper_y_position+[.5 .5 -.5 -.5],'b',...   %linea verticale
        limit_dx-[(limit_dx - m2_dx)/2-1,0], damper_y_position + [0 0]','b','LineWidth',2);
    
   
    pause(T_pause);
    flag = 1;
    
end
                     
figure(3)


subplot(3,1,1)    %posizioni
    hold on
    xlim(tspan);
    plot(t,y(:,1),'r')
    hold on
    plot(t,y(:,2),'b')
    title('Posizioni')
    xlabel('tempo [s]')
    ylabel('spostamento [m]')
    legend('Blocco 1','Blocco 2')
   
subplot(3,1,2)    %velocita
    hold on
    plot(t,y(:,2),'r') %le v_1
    plot(t,y(:,4),'b')
     title('Velocità')
    xlabel('tempo [s]')
    ylabel('velocità [m/s]')
    legend('Blocco 1','Blocco 2')
    
subplot(3,1,3)
    hold on
    plot(t,a1,'r') %le v_1
    plot(t,a2,'b')
     title('Accelerazioni')
    xlabel('tempo [s]')
    ylabel('accelerazione [m/s^2]')
    legend('Blocco 1','Blocco 2')

    