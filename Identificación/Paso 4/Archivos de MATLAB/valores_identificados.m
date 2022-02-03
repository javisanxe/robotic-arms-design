
clear all
close all
clc


% ARCHIVO DE ALMACENAMIENTO DE LOS VALORES IDENTIFICADOS DE LOS PARÁMETROS DEL
% STEP 4 DE LUGRE:

sigma0_id(1) = mean([8.231675
6.574423
8.234382
8.851999
8.980696
7.551488]);

sigma0_id(2) = mean([41.751341
52.458252
42.919563
41.174534
47.139352
32.322477]);

sigma1_id(1) = mean([2.135800
1.903102
2.136160
2.216772
2.233213
2.043421]);

sigma1_id(2) = mean([2.430120
2.731350
2.464733
2.412851
2.585995
2.130831]);


name=strcat('Valores_identificados_STEP4.mat');
save(name,'sigma0_id','sigma1_id');

disp(' ');
disp('Valores identificados en el step 4 guardados en');
disp(name);



