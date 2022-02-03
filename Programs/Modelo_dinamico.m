%Modelo dinámico del robot despreciando la fricción:

%(Cálculo con los parámetros conocidos de diseño).
syms q1 q2 dq1 dq2 ddq1 ddq2 tau1 tau2
%Datos necesarios
m1=16.17;  %Masa de Articulación 1
m2=1.74;   %Masa de Articulación 2

L1=0.45;   %Longitud de la articulación 1
L2=0.45;   %Longitud de lA arituclación 2
Lc1=0.357; %Distancia al cdg1
Lc2=0.192; %Distancia al cdg2

Izz1=2.65842; %Inercia respecto al eje de giro de la articulación 1
Izz2=0.10893; %Inercia respecto al eje de giro de la articulación 2

%Motores (Datos de pdf diseño, comprobar que esten bien)
mm2=11.5; %Masa de motor Articulación 2
Imzz1=0.0042; %Inercia respecto al eje de giro del motor de la articulacion 1
Imzz2=0.0654; %Inercia respecto al eje de giro del motor de la arciculación 2


Kr1=1;
Kr2=1; %Constante de reduccion
g=9.81; %Aceleración de la gravedad

b1=8.38*(10^-5);
fe1=1.36;

b2=3.09*(10^-6);
fe2=0.2;
% %% Modelo.
% 
% %M(q)*ddq + C(q,dq)*dq + G(q) + Ff(dq) = Tau(t)
% %%Podemos poner en simbólico q,dq
% 
% %Matriz de Incercia   f(q)
% 
% M11=m1*(Lc1^2 )+ m2*(L1^2) + (Kr1^2)*Imzz1 + m2*(Lc2^2) + mm2*(L1^2) + Izz1 + Imzz2 + Izz2 + 2*m2*L1*Lc2*cos(q2);
% M12=                                         m2*(Lc2^2)                     + Imzz2 + Izz2 +   m2*L1*Lc2*cos(q2);
% M21=M12;
% M22=                                         m2*(Lc2^2)                     + Imzz2 + Izz2;
% 
% M=[M11 M12;M21 M22];
% 
% %Matriz de fuerzas centrípetas y Coriolis  f(q,dq)
% 
% C11=-m2 * L1 * Lc2*  dq2      * sin(q2);
% C12=-m2 * L1 * Lc2* (dq1+dq2) * sin(q2);
% C21= m2 * L1 * Lc2*  dq1      * sin(q2);
% C22=0;
% 
% C=[C11 C12;C21 C22];
% %Vector de fuerzas gravitatorias
% 
% G1=(m1*Lc1+mm2*L1+m2*L1)*g*sin(q1) + m2*Lc2*g*sin(q1+q2);
% G2=                                  m2*Lc2*g*sin(q1+q2);


%Modelo de fricción Ff(dq,tau)

% b1, b2, fc1, fc2 (Parámetros desconocidos)

% Ff=[ b1*dq1 + fc1*sign(dq1);           %%Saturación??
%      b2*dq2 + fc2*sign(dq2) ]

 
 k1=m1*(Lc1^2 )+ m2*(L1^2) + (Kr1^2)*Imzz1 + m2*(Lc2^2) + mm2*(L1^2) + Izz1 + Imzz2 + Izz2;
 k2=m2*L1*Lc2;
 k3=(Kr2^2)*Imzz2 + m2*(Lc2^2)+ Izz2;
 k4=(m1*Lc1+mm2*L1+m2*L1)*g;
 k5=m2*Lc2*g;

 
 
% A falta de comprobar el peso de los motores
%     7.6430
%     0.1503
%     0.2385
%   115.0781
%     3.2773
 
 
 
 
 
 
 
 
%Parametros identificados y validados:
% k1=0.1386;
% k2=0.0046;
% k3=0.0372;
% k4=2.183;
% k5=0.495; %% hombro=0.114, codo=0.8761
%           %% HOMBRO        CODO
% sigma0       8.0708        42.9609
% sigma1       2.1114        2.4593
% sigma2       0.053         0.0581
% Fc_mas       0.0075        0.0871 (0.25 corregido)
% Fc_menos     0.0215        0.0421 (0.1861 corregido)
% Fs_mas       0.0707        0.03515
% Fs_menos     0.0777        0.3834
% dqs          0.1572        0.1155
 
%M(q)*ddq + C(q,dq)*dq + G(q) + Ff(dq) = Tau(t) 
 
M11=k1 + 2*k2*cos(q2);
M12=k3 +   k2*cos(q2);
M21=M12;
M22=k3;

M=[M11 M12; M21 M22];

%Matriz de fuerzas centrípetas y Coriolis  f(q,dq)

C11=-k2 *  dq2      * sin(q2);
C12=-k2 * (dq1+dq2) * sin(q2);
C21= k2 *  dq1      * sin(q2);
C22=0;

C=[C11 C12;C21 C22];

%Vector de fuerzas gravitatorias

G1=k4*sin(q1) + k5*sin(q1+q2);
G2=             k5*sin(q1+q2);

G=[G1;G2];

%Modelo de fricción Ff(dq,tau)

% b1, b2, fc1, fc2, fe1, fe2


Ff=[b1*dq1+(1-abs(sign(dq1)))*fe1 ; b2*dq2+(1-abs(sign(dq2)))*fe2];    %fc2*sign(dq2)




%%Modelo
tau=M*[ddq1;ddq2] + C*[dq1;dq2] + G + Ff;

% vpa(simplify(tau),3);
% %Sensibilidad pares Nm/Amperio
kt1=21.4;
kt2=4.43;

tau_amperios=[tau(1,1)/kt1;tau(2,1)/kt2];

ec=vpa(simplify(tau_amperios),3)




%M(q)*ddq + C(q,dq)*dq + G(q) + Ff(dq) = Tau(t) 
 

% Mddq=[0.0467*ddq2*(0.15*cos(q2) + 0.238) + 0.0467*ddq1*(0.301*cos(q2) + 7.64)
%    0.0538*ddq2 + 0.226*ddq1*(0.15*cos(q2) + 0.226)
% 
% M=[0.0467*(0.301*cos(q2) + 7.64)   ,0.0467*0.238 + 0.0467*0.15*cos(q2);
%    0.226*(0.15*cos(q2) + 0.238)  ,  0.0538*ddq2] 
%    
   
   
   % 
% 
% C=[- 0.00703*dq1*dq2*sin(q2) - 0.0467*dq2*sin(q2)*(0.15*dq1 + 0.15*dq2)
%       0.0339*sin(q2)*dq1^2
% 
% G=[+ 0.153*sin(q1 + q2) + 5.38*sin(q1)
%    + 0.74*sin(q1 + q2)
% 
% Ff=[3.92e-6*dq1 - 0.0636*abs(sign(dq1))
%     6.98e-7*dq2 - 0.0451*abs(sign(dq2))
% 
% 
% 0.0467
% 0.226





