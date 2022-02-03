%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funci�n para la estimaci�n de 

% inercia --------------> J
% Fricci�n de Coulomb---> Fc
% Fricci�n viscosa -----> sigma2
% Posicion cdg ---------> xcdg

% La funci�n emplea el procedimiento descrito como paso 1  del
% procedimiento de identificaci�n de fricci�n de LUGRE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ka,kb,kc,Fc,sigma2,error]=step1_hombro_GB(Phi1_mdl,y1_mdl,qp,nlink)
% Discriminaci�n de velocidades positivas v > vs_est  (velocidad stribeck
% estimada)

vmin=0.1;

% Articulaci�n del Hombro
n=size(Phi1_mdl,1);
nsamp=1e4; % Se toman �nicamente las nsamp �ltimas muestras
if n-nsamp<1
    samp_inic=1; 
else
    samp_inic=n-nsamp;
end
cont=1;
Phi1f={};
y1f={};

% Filtramos las medidas correspondientes a velocidad mayor que vmin
for i=samp_inic:n
    if (abs(qp(i,nlink))>vmin)
    %if(abs(qp(i,nlink))>5.5)&&(abs(qp(i,nlink))<11)
        Phi1f{cont}=Phi1_mdl(i,:)';
        y1f{cont}=y1_mdl(i,1);
        cont=cont+1;
    end
end

[theta,error]=ewrls(Phi1f,y1f,[0 0 0 0 0]',1);
ka=theta(1);
kb=theta(2);
kc=theta(3);
Fc=theta(4);
sigma2=theta(5);

