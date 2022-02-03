%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funci�n para la estimaci�n de 

% inercia --------------> J
% Fricci�n de Coulomb---> Fc
% Fricci�n viscosa -----> sigma2
% Posicion cdg ---------> xcdg

% La funci�n emplea el procedimiento descrito como paso 1  del
% procedimiento de identificaci�n de fricci�n de LUGRE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [k3,k5,Fc,sigma2,error]=step1_codo_GB(Phi2_mdl,y2_mdl,qp,nlink)
% Discriminaci�n de velocidades positivas v > vs_est  (velocidad stribeck
% estimada)

vmin=0.1;

% Articulaci�n del Codo
n=size(Phi2_mdl,1);
nsamp=1e4; % Se toman �nicamente las nsamp �ltimas muestras
if n-nsamp<1
    samp_inic=1; 
else
    samp_inic=n-nsamp;
end
cont=1;
Phi2f={};
y2f={};

% Filtramos las medidas correspondientes a velocidad mayor que vmin
for i=samp_inic:n
    %if (abs(qp(i,nlink))>10) && (abs(qp(i,nlink))<17)
    if abs(qp(i,nlink))>vmin
        Phi2f{cont}=Phi2_mdl(i,:)';
        y2f{cont}=y2_mdl(i,1);
        cont=cont+1;
    end
end

[theta,error]=ewrls(Phi2f,y2f,[0 0 0 0]',1);
k3=theta(1);
k5=theta(2);
Fc=theta(3);
sigma2=theta(4);

