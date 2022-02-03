% Cálculo de las constantes del PI necesario para la obtención de ciclos
% límites por fricción ('Hunting') de STEP2

function [Kp,Ki,T]=PI_hunting(J,sigma2,Fc)

A=90*pi/180; % Amplitud deseada de las oscilaciones (en rad)
T=30; % Periodo de las oscilaciones (en seg)
% Por Routh-Hurwitz sobre la función de transferencia aproximada, sabemos
% que Ki<sigma2/J para estabilidad

Kimax=sigma2/J;
% Estimamos la fricción estática como un 20% superior a la de Coulomb
Fs_est=1.3*Fc;

Kp=(Fs_est-Fc)/(2*A);
%T=4*(Kp/Ki)*(Fs_est+Fc)/(Fs_est-Fc);
Ki=4*(Kp/T)*(Fs_est+Fc)/(Fs_est-Fc);
if Ki>Kimax
    Ki=0.9*Kimax;
    T=4*(Kp/Ki)*(Fs_est+Fc)/(Fs_est-Fc);
end
