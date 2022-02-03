
clear all
close all
clc


% ARCHIVO DE CÁLCULO Y ALMACENAMIENTO DE LOS VALORES IDENTIFICADOS DE LOS PARÁMETROS DEL
% STEP 2 DE LUGRE:

% Considerando los experimentos 1 y 4 para el hombro
% Considerando los experimentos 1 y 4 para el codo

Fs_mas_id(1) = mean([0.050864,0.099948,0.071526,0.060521]);
Fs_mas_id(2) = mean([0.323024,0.351241,0.345923,0.385986]);

Fs_menos_id(1) = mean([0.101251,0.054239,0.077524,0.077851]);
Fs_menos_id(2) = mean([0.479105,0.401638,0.388397,0.264327]);

Fs_id(1)=(Fs_mas_id(1)+Fs_menos_id(1))/2;
Fs_id(2)=(Fs_mas_id(2)+Fs_menos_id(2))/2;

name=strcat('Valores_identificados_STEP2.mat');
save (name,'Fs_mas_id','Fs_menos_id','Fs_id');

disp(' ');
disp('Valores identificados en el step 2 guardados en');
disp(name);



