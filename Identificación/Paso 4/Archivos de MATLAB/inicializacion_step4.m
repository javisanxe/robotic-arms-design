
% Archivo de inicialización de parámetros para el modelo: Ident_friccion_step4_GB.mdl

clear all
close all
clc

% Precisión de los encoders en pulsos por vuelta:

precisiones = [524288 262144 131072 65536 32768 16384 8192 4096 2048 1024];

precision = precisiones(1);

% Valor de pulsos de encoder de comparación para detección del paso por
% cero:

zero_h = 5;
zero_c = 5;

% Constante de tiempo tau1 para el filtro de derivación (inversa)

tau1=0.008; % Cte de tiempo del filtro de derivación
N = 1/tau1;

% Parámetros dinámicos necesarios:
        
name1 = ('Valores_identificados_STEP1.mat');
load(name1);

name2 = ('Valores_identificados_STEP2.mat');
load(name2);

name3 = ('Valores_identificados_STEP3.mat');
load(name3);

% Secuencias que se repiten como referencia de posición:

%vect = [0 1 2 3 4 5 6];
%vect = [0 2 4 6 8 10 12];
%vect = [0 3 6 9 12 15 18];
vect = [0:3.5:21];
%vect = [0 4 8 12 16 20 24];
%vect = [0 5 10 15 20 25 30];
vectq1 = [0 1 1 0 -1 -1 0];
vectq2 = [0 1 1 0 -1 -1 0];

% Constantes atenuadoras:

K1 = 0.01;
K2 = 0.05;




