%FUNCION CREACION DE TRAYTECTORIAS PREDISEÑADAS
%%Ejemplo figuras geometricas trayectorias vertices (Lineal entre punto y otro)

%% Creación trayectoria discreta en cartesinas
L1=0.45;
L2=0.45;

%Variables de entrada

vertices=6;   %Numero de vertices (PAR)
Tfigura=24;    %Duración en realizar la trayectoria de figura geométrica

Tsegmento=Tfigura/vertices; %Tiempo de un vertice a otro (QUE SEA ENTERO!!!!)

Treposo=4;  %Tiempo reposo->pinicial=pfinal->reposo

Ttotal=Tfigura+Treposo*2;



%N_puntos_tray=100;
%delta=Tfigura/N_puntos_tray
delta=0.1;
Rmax=L1+L2;

%Margen de precaución, Circunferencia que contiene a las figuras
%geometricas de radio:
R=0.8*Rmax;
R2=0.3*Rmax;

Origen = transl([Rmax 0 0]);
Angulo=(2*pi)/vertices;


%Definimos los vertices de la figura
for i=1:1:vertices
    
if(mod(i,2)==0) %Si es par   
V(:,:,i)=transl([abs(R*cos(Angulo*(i))) -abs(R*sin(Angulo*(i))) 0]);
else            %Si es impar
V(:,:,i)=transl([-abs(R *cos(Angulo*(i))) -abs(R *sin(Angulo*(i))) 0]);
end

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