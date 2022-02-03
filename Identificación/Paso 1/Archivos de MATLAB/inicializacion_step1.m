
% Archivo de inicialización de parámetros para el modelo: Ident_friccion_step1_GB2.mdl

clear all
close all
clc

% Amplitud K de los pares senoidales de entrada:

K1 = 1.1;
K2 = 1.1;

% Frecuencia w de los pares senoidales de entrada:

w1 = 4;
w2 = 4;

% Constante de tiempo tau1 para el filtro de derivación (inversa N)

tau1 = 0.1; 
N = 1/tau1;

% Constante de tiempo tau2 del filtro para el par analógico

tau2 = 0.05;

% Constante de tiempo tau del filtro paso bajo para el regresor

tau = 0.001;
lambda_reg = 1/tau;


% Precisión de los encoders en pulsos por vuelta:

precisiones = [524288 262144 131072 65536 32768 16384 8192 4096 2048 1024];

precision = precisiones(7);

% Valor de pulsos de encoder de comparación para detección del paso por
% cero:

zero_h = 200;
zero_c = 1500;
