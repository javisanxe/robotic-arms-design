
close all

L1=0.45;
L2=0.45;


%%Posiciones
Grafica2(t,[qd(:,1) q(:,1) qd(:,2) q(:,2)])
%%Velocidades
Grafica2b(t,[qp_d(:,1) qp(:,1) qp_d(:,2) qp(:,2)])

%%Errores
e=qd-q;
ep=qp_d-qp;

Grafica21(t,[e(:,1) e(:,2)],[ep(:,1) ep(:,2)]);


%%Pares
%Grafica_pares(t,[u(:,1) u(:,2)])

%%Trayectoria extremo
Trayectoria_deseada=CD(q_d);
xy_d=transl(Trayectoria_deseada);

Trayectoria_real=CD(q);
xy=transl(Trayectoria_real);

cartesianas(xy_d(:,2),-xy_d(:,1),xy(:,2),-xy(:,1),0,[0 -0.9])




%%
%%Posiciones
pos(t,q,t_d,q_d)
%%Velocidades
vel(t,qp,t_d,qp_d)

%%Trayectoria extremo
Trayectoria_deseada=CD(q_d);
xy_d=transl(Trayectoria_deseada);

Trayectoria_real=CD(q);
xy=transl(Trayectoria_real);

cartesianas(xy_d(:,2),-xy_d(:,1),xy(:,2),-xy(:,1),0,[0 -0.9])