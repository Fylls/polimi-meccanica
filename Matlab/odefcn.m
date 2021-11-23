function dydt=odefcn(y,M,k1,k2,k3,c1,c2,c3)

%si potrebbe fare invertendo la matrice delle masse ma è la stessa cosa

    dx_1dt = y(2);
    dv_1dt = ((-k1-k2)*y(1)+(-c1-c2)*y(2)+k2*y(3)+c2*y(4));
    dx_2dt = y(4);
    dv_2dt = (k2*y(1)+c2*y(2)+(-k2-k3)*y(3)+(-c2-c3)*y(4));
    dydt=inv(M)*[dx_1dt dv_1dt dx_2dt dv_2dt]';
