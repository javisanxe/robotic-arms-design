
clear all
close all
clc


% ARCHIVO DE CÁLCULO Y ALMACENAMIENTO DE LOS VALORES IDENTIFICADOS DE LOS PARÁMETROS DEL
% STEP 3 DE LUGRE:

vs_id(1) = mean([0.106522, 0.176756, 0.217123, 0.220075, 0.065311]);
vs_id(2) = mean([0.106310, 0.136281, 0.119687, 0.121466, 0.093926]);

name=strcat('Valores_identificados_STEP3.mat');
save (name,'vs_id');

disp(' ');
disp('Valores identificados en el step 3 guardados en');
disp(name);



