%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Función para la estimación de 

% inercia --------------> J
% Fricción de Coulomb---> Fc
% Fricción viscosa -----> sigma2
% Posicion cdg ---------> xcdg

% La función emplea el procedimiento descrito como paso 1  del
% procedimiento de identificación de fricción de LUGRE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ka,kb,kc,Fc,sigma2,error]=step1_hombro_GB(Phi1_mdl,y1_mdl,qp,nlink)
% Discriminación de velocidades positivas v > vs_est  (velocidad stribeck
% estimada)

vmin=0.1;

% Articulación del Hombro
n=size(Phi1_mdl,1);
nsamp=1e4; % Se toman únicamente las nsamp últimas muestras
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

