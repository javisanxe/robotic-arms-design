%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funci�n para la estimaci�n de 

% velocidad de Stribeck --------------> vs


% La funci�n emplea el procedimiento descrito como STEP 3  del
% procedimiento de identificaci�n de fricci�n de LUGRE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Discriminaci�n de velocidades positivas v > vs_est  (velocidad stribeck
% estimada)

function [vs]=step3(qp,qpp,u,J,Fs,Fc)

n=size(qp,1);
nsamp=2e5; % Se toman �nicamente las nsamp �ltimas muestras
if n-nsamp<1
    samp_inic=1; 
else
    samp_inic=n-nsamp;
end
cont=1;
Phif={};
yf={};
% Filtramos las medidas con gamma>1
for i=samp_inic:n
    yaux=qp(i)^2;
    gamma_aux=(Fs-Fc)/((u(i)-J*qpp(i))*sign(qp(i))-Fc);
    %if gamma_aux>=1
    if gamma_aux>1
        Phif{cont}=log(gamma_aux);
        yf{cont}=yaux;
        cont=cont+1;
    end
end
[theta,error]=ewrls(Phif,yf,[0]',1);
vs=sqrt(theta);
