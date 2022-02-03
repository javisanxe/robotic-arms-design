
clear all

disp('IDENTIFICACIÓN DE PARÁMETROS DINÁMICOS A PARTIR DE LOS RESULTADOS DEL STEP 1');

% Identificación de k1 y k2:

ya_mdl = [0.146337
0.148439
0.148290
0.139852
0.141922
0.142722
0.138558
0.140624
0.139707
0.130271
0.132178
0.131991
0.128941
0.130374
0.130146];

q2 = [0
0
0
1.2134
1.2134
1.2134
-1.514
-1.514
-1.514
2.3813
2.3813
2.3813
-2.9493
-2.9493
-2.9493];

Phia_mdl = ones(length(ya_mdl),2);
Phia_mdl(:,2)= 2*cos(q2);

[k1_id,k2_id,error_din_a] = step1_hombro_GB_din_a(Phia_mdl,ya_mdl);

% Identificación de k4 y k5:

yb_mdl = [2.295054
2.269384
2.268519
2.260220
2.220248
2.216868
2.238867
2.209458
2.193565
2.056102
2.095868
2.089043
2.101773
2.069509
2.062633];

Phib_mdl = ones(length(yb_mdl),2);
Phib_mdl(:,2)= cos(q2);

[k4_id,k5_id,error_din_b] = step1_hombro_GB_din_b(Phib_mdl,yb_mdl);

yc_mdl = [-0.033096
-0.034502
0.059676
0.047890
0.024547
0.085889
-0.073280
-0.104405
-0.023124
0.072502
0.032723
0.090923
-0.053169
-0.037025
0.030209];

Phic_mdl = ones(length(yc_mdl),1);
Phic_mdl(:,1)= sin(q2);

[k5_id_c,error_din_c] = step1_hombro_GB_din_c(Phic_mdl,yc_mdl);

