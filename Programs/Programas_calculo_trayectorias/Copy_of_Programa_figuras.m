%FUNCION CREACION DE TRAYTECTORIAS PREDISEÑADAS
%%Ejemplo figuras geometricas trayectorias vertices (Lineal entre punto y otro)

%% Creación trayectoria discreta en cartesinas
L1=0.45;
L2=0.45;

%Variables de entrada

vertices=6;   %Numero de vertices
Tfigura=6;    %Duración en realizar la trayectoria de figura geométrica

Tsegmento=Tfigura/vertices; %Tiempo de un vertice a otro (QUE SEA ENTERO!!!!)

Treposo=2;  %Tiempo reposo->pinicial=pfinal->reposo

Ttotal=Tfigura+Treposo*2;



%N_puntos_tray=100;
%delta=Tfigura/N_puntos_tray
delta=0.1;
Rmax=L1+L2;

%Margen de precaución, Circunferencia que contiene a las figuras
%geometricas de radio:
R=0.8*Rmax;

Origen = transl([Rmax 0 0]);
Angulo=(2*pi)/vertices;


%Definimos los vertices de la figura
for i=1:1:vertices
    
V(:,:,i)=transl([R*cos(Angulo*(i+1)) R*sin(Angulo*(i+1)) 0]);

end

%transl(V) = vectores (x y z)

t = [0,Treposo:delta:Tfigura+Treposo,Tfigura+Treposo*2]'; %Tiempos de las posiciones de la trayectoria (FALTA INCICIO Y FIN)

Muestras_segmento=length([0:delta:Tsegmento]);
TRAY = ctraj(Origen,V(:,:,1),2);

for i=1:1:vertices-1

final = size(TRAY,3);   
TRAY(:,:,final:final+Muestras_segmento-1)=[ctraj(V(:,:,i),V(:,:,i+1),Muestras_segmento)];

end

final = size(TRAY,3);   
TRAY(:,:,final:final+Muestras_segmento-1)=[ctraj(V(:,:,i+1),V(:,:,1),Muestras_segmento)];
TRAY(:,:,final+Muestras_segmento)=Origen;

%size(t)==size(TRAY,3)
xy=transl(TRAY);

%Dibujamos la trayectoria discreta (cartesianas)
figure(1);
plot(xy(:,1),xy(:,2),'b.');
grid on;
xlabel('X (m)');
ylabel('Y (m)');
title('Trayectoria Cartesiana Diseñada');

%% Pasamos a TRAYECTORIA EN COORD. ARTICULARES 
%(2 OPCIONES: Brazo arriba/Brazo abajo)

[qa,qb]=CI(TRAY);

%Trabajamos con coord. 0-2pi para observar resultados más comodo
for i=1:length(t)
    for k=1:2
    if qa(i,k)<0
        qa(i,k)=qa(i,k)+2*pi;
    end
    end
    
    for k=1:2
    if qb(i,k)<0
        qb(i,k)=qb(i,k)+2*pi;
    end
    end
end

% %Representado
% figure(2);
% subplot(2,2,1);
% plot(t,(360/(2*pi))*qa(:,1),'b.');
% grid on;
% xlabel('Tiempo (s)');
% ylabel('q1 A (º)');
% 
% subplot(2,2,2);
% plot(t,(360/(2*pi))*qa(:,2),'r.');
% grid on;
% xlabel('Tiempo (s)');
% ylabel('q2 A (º)');
% 
% 
% subplot(2,2,3);
% plot(t,(360/(2*pi))*qb(:,1),'b.');
% grid on;
% xlabel('Tiempo (s)');
% ylabel('q1 B (º)');
% 
% subplot(2,2,4);
% plot(t,(360/(2*pi))*qb(:,2),'r.');
% grid on;
% xlabel('Tiempo (s)');
% ylabel('q2 B (º)');

%% correción:
%---------------Movimiento suave y conbinar codo arriba/codo bien
%---------------Revisión de puntos singulares (puntos sean realizables)

%SUPONEMOS TRAYECTORIA EN COORDENADAS ARTICULARES Discreta ya correcta

%------q------ Trayectoria en coord articulares definitiva

%Comprobación (T1=T2=xy)
% T1=transl(CD(qa));
% T2=transl(CD(qb));
% 
% T=[xy(:,1)-T1(:,1) xy(:,2)-T1(:,2)];    &&   T=[xy(:,1)-T2(:,1) xy(:,2)-T2(:,2)];





%% Criterios de velocidad  (Necesitamos calcular las velocidades con algun método) 
%Datos partida:
q=qa;%%%%%%%%%%%%%%%%%CAMBIAR
t;

qp=seleccion_velocidades(q,t);

%Representación velocidades diseñadas
figure(3);
subplot(2,1,1);
plot(t,(360/(2*pi))*qp(:,1),'b.');
grid on;
xlabel('Tiempo (s)');
ylabel('Velocidad q1 (Grados/s)');

subplot(2,1,2);
plot(t,(360/(2*pi))*qp(:,2),'r.');
grid on;
xlabel('Tiempo (s)');
ylabel('Velocidad q2 (Grados/s)');

%% Interpolación y muestreo trayectoria articular para posterior control dinámico
%Probaremos diferentes interpoladores:
% -Interpolador lineal--> DESCARTADO (ACELERACIONES INFINITAS)
% -Interpolador cúbico % + continuidad aceleraciones = quintico
% -Interpolador quíntico
% -Interpolador trapezoidal a tramos
% -Interpoladores mas jodidos


%Datos partida:
% q;
% qp;
% t;

%Tiempo de muestreo:
Tm = 0.001;

puntos = length([0:Tm:Ttotal]);

q_d   = zeros(puntos,2); % Posiciones    deseadas
qp_d  = zeros(puntos,2); % Velocidades   deseadas 
qpp_d = zeros(puntos,2); % Aceleraciones deseadas


Muestreo1 = Interpolacion_y_muestreo(t',q(:,1)',qp(:,1)',delta,Tm,Treposo);
Muestreo2 = Interpolacion_y_muestreo(t',q(:,2)',qp(:,2)',delta,Tm,Treposo);

if length(Muestreo1)==puntos
    disp('LAS CLAVAO')
end




t_d(1:puntos)    =  Muestreo1(:,1);
q_d(1:puntos,1)   = Muestreo1(:,2);
qp_d(1:puntos,1)  = Muestreo1(:,3);
qpp_d(1:puntos,1) = Muestreo1(:,4);

q_d(1:puntos,2)   = Muestreo2(:,2);
qp_d(1:puntos,2)  = Muestreo2(:,3);
qpp_d(1:puntos,2) = Muestreo2(:,4);






%Al final de la interpolacion AÑADIRRRRR???
% qd(puntos,:)    = qd(puntos-1,:);
% qp_d(puntos,:)  = qp_d(puntos-1,:);
% qpp_d(puntos,:) = qpp_d(puntos-1,:);


TRAYFINAL=CD(q_d);

xyfinal=transl(TRAYFINAL);

plot(xyfinal(:,1),xyfinal(:,2),'r');








