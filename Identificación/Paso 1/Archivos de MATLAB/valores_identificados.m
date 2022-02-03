
clear all
close all
clc


% ARCHIVO DE CÁLCULO DE LOS VALORES IDENTIFICADOS DE LOS PARÁMETROS DEL
% STEP 1 DE LUGRE:

% Articulación 1 (hombro):

ka_vec = [0.144666
0.144291
0.150683
0.144371
0.143466];

ka_id = mean(ka_vec);


kb_vec = [2.257205
2.249570
2.375689
2.237196
2.222087];

kb_id = mean(kb_vec);


kc_vec = [0.021702
0.021520
0.027649
0.021616
0.007469];

kc_id = mean(kc_vec);


Fc_vec = [0.009971
0.017907
0.015761
0.001924];
 
Fc_id(1) = mean(Fc_vec);


sigma2_vec = [0.001658
0.005782
0.003609
0.002023
0.001136];

sigma2_id(1) = mean(sigma2_vec);

% Articulación 2 (codo):

k3_vec = [0.051386
0.045406
0.068801
0.031642
0.034288
0.051109
0.039619];

k3_id = mean(k3_vec);


k5_vec = [0.719560
0.564807
1.453667
0.787390
0.829775
1.049834
1.044646];

k5_id = mean(k5_vec);

Fc_vec = [0.051262
0.080881
0.120639
0.045940
0.007468
0.077017
0.056761];
 
Fc_id(2) = mean(Fc_vec);


sigma2_vec = [0.008769
0.035347
0.019446
0.002097
0.007435
0.013458
0.014309];

sigma2_id(2) = mean(sigma2_vec);

disp('Los valores dinámicos identificados son:')
disp(' ')
s=sprintf('Para el hombro:\n\nka = %f\nkb = %f\nkc = %f\nFc(%d) = %f\nsigma2(%d) = %f\n',ka_id,kb_id,kc_id,1,Fc_id(1),1,sigma2_id(1));
disp(s)

s=sprintf('Para el codo:\n\nk3 = %f\nk5 = %f\nFc(%d) = %f\nsigma2(%d) = %f\n',k3_id,k5_id,2,Fc_id(2),2,sigma2_id(2));
disp(s)

name=strcat('Valores_identificados_STEP1.mat');
save (name,'ka_id','kb_id','kc_id','k3_id','k5_id','Fc_id','sigma2_id');

disp(' ');
disp('Valores identificados en el step 1 guardados en');
disp(name);


