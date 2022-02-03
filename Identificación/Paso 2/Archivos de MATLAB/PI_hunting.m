
% C�lculo de las constantes del PI necesario para la obtenci�n de ciclos
% l�mites por fricci�n ('Hunting') del STEP2 del m�todo de Lugre:


function [Kp,Ki,T]=PI_hunting(J,sigma2,Fc)

A=90*pi/180; % Amplitud deseada de las oscilaciones (en radianes)
T=5; % Per�odo de las oscilaciones (en segundos)

% Por Routh-Hurwitz sobre la funci�n de transferencia aproximada, sabemos
% que Ki<sigma2/J para estabilidad

Kimax=sigma2/J;

% Estimamos la fricci�n est�tica como un 30% superior a la de Coulomb
Fs_est=1.3*Fc;

Kp=(Fs_est-Fc)/(2*A);

%T=4*(Kp/Ki)*(Fs_est+Fc)/(Fs_est-Fc);

Ki=4*(Kp/T)*(Fs_est+Fc)/(Fs_est-Fc);

if Ki>Kimax
    Ki=0.99*Kimax;
    T=4*(Kp/Ki)*(Fs_est+Fc)/(Fs_est-Fc);
end
