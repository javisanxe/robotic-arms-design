% 3.-Tomar una muestra de puntos significativa, pasarlo a coord. articulares,
% interpolar y muestrear
% 
% -Hay que asegurarse de una trayectoria de q y dq suave, si hace falta habra que hacer
% hacer un tratamiento a la trayectoria al inicio para que no sea muy irregular

Muestras=[];
length(XY)  %Numero puntos trayectoria

puntos=200; %Puntos que queremos para muestra representativa 

paso=floor(length(XY)/puntos);

for i=1:length(XY)
    
    if(mod(i,paso)==0)
        
        Muestras=[Muestras; XY(i,1), XY(i,2) 0];
    end
end

figure
plot(XY(:,1),XY(:,2),'r',Muestras(:,1),Muestras(:,2),'*')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L1=0.45;
L2=0.45;

% *delta=puntos/Tfigura, atento que delta sea un numero GUAY
Tfigura=22;    %Duración en realizar la trayectoria de figura geométrica

Treposo=4;  %Tiempo reposo->pinicial=pfinal->reposo

Ttotal=Tfigura+Treposo*2;

delta=Tfigura/(puntos-1)



%Posiciones, incluyendo reposo al inicio y al final, en Matrices homogéneas
Origen = transl([0.9 0 0]);

TRAY=[];
TRAY(:,:,1)=Origen;
TRAY(:,:,2:length(Muestras)+1)=transl(Muestras); 
TRAY(:,:,length(Muestras)+2)=TRAY(:,:,2)
TRAY(:,:,length(Muestras)+3)=Origen;

%Tiempos respectivos a estas posiciones
% t = [0,Treposo:delta:Tfigura+Treposo,Ttotal]'; %Tiempos de las posiciones de la trayectoria 

 t = [0,linspace(Treposo,Tfigura+Treposo,puntos+2),Ttotal]'; %Para chapa 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%
% qa(2:10,1)=qa(2:10,1)-2*pi;
% qa(end,1)=qa(end,1)+2*pi;
%Representado
figure(2);
subplot(2,2,1);
plot(t,(360/(2*pi))*qa(:,1),'b.');
grid on;
xlabel('Tiempo (s)');
ylabel('q1 A (º)');

subplot(2,2,2);
plot(t,(360/(2*pi))*qa(:,2),'r.');
grid on;
xlabel('Tiempo (s)');
ylabel('q2 A (º)');


subplot(2,2,3);
plot(t,(360/(2*pi))*qb(:,1),'b.');
grid on;
xlabel('Tiempo (s)');
ylabel('q1 B (º)');

subplot(2,2,4);
plot(t,(360/(2*pi))*qb(:,2),'r.');
grid on;
xlabel('Tiempo (s)');
ylabel('q2 B (º)');

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

puntos = length([0:Tm:Ttotal])-2;

q_d   = [] ;% Posiciones    deseadas
qp_d  =  [];% Velocidades   deseadas 
qpp_d =   []; % Aceleraciones deseadas


Muestreo1 = Interpolacion_y_muestreo(t',q(:,1)',qp(:,1)',delta,Tm,Treposo);
Muestreo2 = Interpolacion_y_muestreo(t',q(:,2)',qp(:,2)',delta,Tm,Treposo);

if length(Muestreo1)==puntos
    disp('LAS CLAVAO')
end




t_d    =  Muestreo1(:,1);
q_d(:,1)   = Muestreo1(:,2);
qp_d(:,1)  = Muestreo1(:,3);
qpp_d(:,1) = Muestreo1(:,4);

q_d(:,2)   = Muestreo2(:,2);
qp_d(:,2)  = Muestreo2(:,3);
qpp_d(:,2) = Muestreo2(:,4);



%Al final de la interpolacion AÑADIRRRRR:NO???
% qd(puntos,:)    = qd(puntos-1,:);
% qp_d(puntos,:)  = qp_d(puntos-1,:);
% qpp_d(puntos,:) = qpp_d(puntos-1,:);


TRAYFINAL=CD(q_d);

xyfinal=transl(TRAYFINAL);

plot(xyfinal(:,1),xyfinal(:,2),'r');


%Coordenadas articulares y velocidades
figure();
subplot(2,2,1);
plot(t_d,(360/(2*pi))*q_d(:,1),'b.');
grid on;
xlabel('Tiempo (s)');
ylabel('q HOMBRO (º)');

subplot(2,2,2);
plot(t_d,(360/(2*pi))*qp_d(:,1),'r.');
grid on;
xlabel('Tiempo (s)');
ylabel('Velocidad Hombro (º/s)');


subplot(2,2,3);
plot(t_d,(360/(2*pi))*q_d(:,2),'b.');
grid on;
xlabel('Tiempo (s)');
ylabel('q CODO (º)');

subplot(2,2,4);
plot(t_d,(360/(2*pi))*qp_d(:,2),'r.');
grid on;
xlabel('Tiempo (s)');
ylabel('Velocidad Codo (º/s)');









