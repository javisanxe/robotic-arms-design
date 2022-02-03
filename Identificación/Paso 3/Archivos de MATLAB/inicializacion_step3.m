
% Archivo de inicializaci�n de par�metros para el modelo: Ident_friccion_step3_GB2.mdl

close all
clear all
clc

% Precisi�n de los encoders en pulsos por vuelta:

precisiones = [524288 262144 131072 65536 32768 16384 8192 4096 2048 1024];

precision = precisiones(7);

% Valor de pulsos de encoder de comparaci�n para detecci�n del paso por
% cero:

zero_h = 100;
zero_c = 100;

% Constante de tiempo tau1 para el filtro de derivaci�n (inversa)

tau1=0.008; % Cte de tiempo del filtro de derivaci�n
N = 1/tau1;

% Par�metros din�micos necesarios:
        
name2 = ('Valores_identificados_STEP1.mat');
load(name2);

name3 = ('Valores_identificados_STEP2.mat');
load(name3);

% Amplitud K de las referencias para las articulaciones:

K1 = 0.35;
K2 = 0.35;

% Frecuencia w de las referencias para las articulaciones:

w1 = 0.25;
w2 = 0.25;




