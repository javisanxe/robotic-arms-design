%% Datos del robot:
clc, clear all;
syms q1 q2 q3 q4 q5 q6;
% %Variables simbolicas para no tener que meter los datos
 pi=sym('pi');
 syms L1 L2 L3 L4 L5 L1m L2m L3m L4m;

%Brazo B
%Parámetros geométricos (en m)
% % L1=1;
% % L2=0.3;
% % L3=0.3;
% % L4=0.5;
% % L5=0.5;
% % Parámetros dinámicos
% % 
% % 
% % %Muñeca 1
% % Parámetros geométricos (en m)
% % L1m=0;
% % L2m=0.15;
% % L3m=0.15;
% % L4m=0.1;

%% Matrices de transformación homogénea y cinemática directa:
%MDH==trotz(theta)*transl(0,0,d)*transl(a,0,0)*trotx(alfa)

% Matriz DH (Toolbox Corke para que quede bonita)
% teta =[q1,pi/2 ,0           ,q4   ,q5  ,q6     ];
% d    =[L1,L2+q2,L4+L5+L1m+q3,L2m  ,0   ,L3m+L4m];
% a    =[0 ,L3   ,0           ,0    ,0   ,0      ];
% alfa =[0 ,pi/2 ,0           ,-pi/2,pi/2,0      ];
% 
% 
% A01=MDH(teta(1),d(1),a(1),alfa(1));
% A12=MDH(teta(2),d(2),a(2),alfa(2));
% A23=MDH(teta(3),d(3),a(3),alfa(3));
% A34=MDH(teta(4),d(4),a(4),alfa(4));
% A45=MDH(teta(5),d(5),a(5),alfa(5));
% A56=MDH(teta(6),d(6),a(6),alfa(6));
% 
% 
% 
% T06=A01*A12*A23*A34*A45*A56;


% % Solo para el brazo.
teta =[q1 ,pi/2  ,0        ];
d    =[L1 ,L2+q2 ,L4+L5+q3 ];
a    =[0  ,L3    ,0        ];
alfa =[0  ,pi/2  ,0        ];
% % 
A01=MDH(teta(1),d(1),a(1),alfa(1));
A12=MDH(teta(2),d(2),a(2),alfa(2));
A23=MDH(teta(3),d(3),a(3),alfa(3));

T03=A01*A12*A23;

p=(T03(1:3,4)).'
% % 
% % Comprobación: fkine a las q's  y ikine a xyz
% % 
% % % Cinematica inversa p->q
% % Reseteo los valores de q
% % q1=0;
% % q2=0;
% % q3=0;
% % 
% % Explicar forma geométrica de cálculo + forma analitica con inversas de DH
x3=p(1);
y3=p(2);
z3=p(3);

R=sqrt((x3^2)+(y3^2));
r=sqrt((R^2)-(L3^2)); %=q3+L4+L5

sen_phi=y3/R;
cos_phi=x3/R;
phi=atan2(sen_phi,cos_phi);

sen_beta= L3/R;
cos_beta= r/R;
beta=atan2(sen_beta,cos_beta);

%Ecuaciones cinemática inversa:
q1=phi-beta;
q2=z3-L1-L2;
q3=r-L4-L5;

q=[q1 q2 q3].';
% % 
% % Comprobar si salen iguales haciendo directa y inversa
% % 
% % 
% % % Dibujar trayectoria circular
% % 
% % Para mi robot, la trayectoria mas obvia y sencilla es en el plano xy.
% % 
% % Para plano xy
% % 
% % Para plano yz
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
 

