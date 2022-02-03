%Analisis resultados experimentos

% %Experimento robot real
% q
% qd
% qp
% t
% u

% %Datos dise�o trayectoria
% q_d
% qp_d
% qpp_d
% t_d (NO USAR ESTE)

L1=0.45;
L2=0.45;

%%%Posicion articular
figure()
subplot(2,1,1);

plot(t,qd(:,1),'b',t,q(:,1),'r','Linewidth',2);
grid on;
xlabel('Tiempo (s)','FontSize',13);
ylabel('Posici�n articular (rad)','FontSize',13);
title('Posici�n articular 1 de referencia frente a real','FontSize',16);
legend('Posici�n deseada','Posici�n real');


subplot(2,1,2);

plot(t,qd(:,2),'b',t,q(:,2),'r','Linewidth',2);
grid on;
xlabel('Tiempo (s)','FontSize',13);
ylabel('Posici�n articular (rad)','FontSize',13);
title('Posici�n articular 2 de referencia frente a real','FontSize',16);
legend('Posici�n deseada','Posici�n real');


%%%Velocidad articular
figure()
subplot(2,1,1);

plot(t,qp_d(:,1),'b',t,qp(:,1),'r','Linewidth',2);
grid on;
xlabel('Tiempo (s)','FontSize',13);
ylabel('Velocidad articular (rad/s)','FontSize',13);
title('Velocidad articular 2 de referencia frente a real','FontSize',16);
legend('Velocidad deseada','Velocidad real');

subplot(2,1,2);

plot(t,qp_d(:,2),'b',t,qp(:,2),'r','Linewidth',2);
grid on;
xlabel('Tiempo (s)','FontSize',13);
ylabel('Velocidad articular (rad)','FontSize',13);
title('Velocidad articular 2 de referencia frente a real','FontSize',16);
legend('Velocidad deseada','Velocidad real');

%%%Pares motores en Amperios
figure()

plot(t,u(:,1),'g',t,u(:,2),'y','Linewidth',2);
grid on;
xlabel('Tiempo (s)','FontSize',13);
ylabel('Intensidad (A)','FontSize',13);
title('Intensidad aplicada en los actuadores','FontSize',16);
legend('Par motor 1','Par motor 2');


%%%Errores posici�n y velocidad
e=qd-q;
ep=qp_d-qp;

figure()
subplot(2,1,1)
plot(t,e(:,1),'g',t,e(:,2),'b','Linewidth',1);
grid on;
xlabel('Tiempo (s)','FontSize',13);
ylabel('Error posici�n (rad)','FontSize',13);
title('Error de posici�n de las articulaciones','FontSize',16);
legend('Error posici�n articulaci�n 1','Error posici�n articulaci�n 2');


subplot(2,1,2)
plot(t,ep(:,1),'g',t,ep(:,2),'b','Linewidth',1);
grid on;
xlabel('Tiempo (s)','FontSize',13);
ylabel('Error velocidad (rad)','FontSize',13);
title('Error de velocidad de las articulaciones','FontSize',16);
legend('Error velocidad articulaci�n 1','Error velocidad articulaci�n 2');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Pasamos a coordenadas cartesianas

Trayectoria_deseada=CD(q_d);
xy_d=transl(Trayectoria_deseada);

Trayectoria_real=CD(q);
xy=transl(Trayectoria_real);

figure();
% plot(xy_d(:,1),xy_d(:,2),'b',xy(:,1),xy(:,2),'r','Linewidth',2);
plot(xy_d(:,2),-xy_d(:,1),'b',xy(:,2),-xy(:,1),'r','Linewidth',2);
hold on;
plot( 0, 0, 'kx', 'MarkerSize', 18, 'LineWidth', 3)
hold on;
plot( 0, -0.9, 'kx', 'MarkerSize', 18, 'LineWidth', 3)

grid on;

xlabel('X (m)','FontSize',13);
ylabel('Y (m)','FontSize',13);
title('Trayectoria extremo del robot referencia frente a real','FontSize',16);
legend('Trayectoria referencia','Trayectoria real');



