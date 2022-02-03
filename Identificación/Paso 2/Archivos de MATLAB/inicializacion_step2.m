
% Archivo de inicialización de parámetros para el modelo: Ident_friccion_step2_GB2.mdl

clear all
close all
clc

% Precisión de los encoders en pulsos por vuelta:

precisiones = [524288 262144 131072 65536 32768 16384 8192 4096 2048 1024];

precision = precisiones(7);

% Valor de pulsos de encoder de comparación para detección del paso por
% cero:

zero_h = 100;
zero_c = 100;

%- Constante de tiempo tau1 para el filtro de derivación (inversa)

tau1=0.008; % Cte de tiempo del filtro de derivación
N = 1/tau1;

% Parámetros dinámicos necesarios:
        
name2 = ('Valores_identificados_STEP1.mat');
load(name2);

% Cálculo de las constantes para los controladores PI:
        
[Kp1,Ki1,T1]=PI_hunting(ka_id,sigma2_id(1),Fc_id(1));
[Kp2,Ki2,T2]=PI_hunting(k3_id,sigma2_id(2),Fc_id(2));
Kp1=0.3;
Ki1=0.0195;
Kp2=0.3;
Ki2=0.0195;

% Kp1 = 0.01;
% Ki1 = 1;
% Kp2 = 1;
% Ki2 = 1;

Fs_est(1) = 1.3*Fc_id(1);
Fs_est(2) = 1.3*Fc_id(2);

A1 = (Fs_est(1) - Fc_id(1))/2/Kp1;

T1c = 4*(Kp1/Ki1)*(Fs_est(1)+Fc_id(1))/(Fs_est(1)-Fc_id(1));

A2 = (Fs_est(2) - Fc_id(2))/2/Kp2;

T2c = 4*(Kp2/Ki2)*(Fs_est(2)+Fc_id(2))/(Fs_est(2)-Fc_id(2));

% Filtro de par para STEP 2:

tau_Fs = 0.001;

% Ángulos de referencia para las articulaciones:

teta1 = 40; % En grados
teta2 = 20; % En grados

