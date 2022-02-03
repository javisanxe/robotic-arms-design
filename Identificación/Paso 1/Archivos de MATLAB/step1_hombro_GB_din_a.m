%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Función para la estimación de k1 y k2

% La función emplea el procedimiento descrito como paso 1  del
% procedimiento de identificación de fricción de LUGRE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [k1,k2,error]=step1_hombro_GB_din_a(Phia_mdl,ya_mdl)

% Articulación del Hombro
n=size(Phia_mdl,1);
nsamp=1e5; % Se toman únicamente las nsamp últimas muestras
if n-nsamp<1
    samp_inic=1; 
else
    samp_inic=n-nsamp;
end
cont=1;
Phiaf={};
yaf={};

for i=samp_inic:n
    Phiaf{cont}=Phia_mdl(i,:)';
    yaf{cont}=ya_mdl(i,1);
    cont=cont+1;
end

[theta,error]=ewrls(Phiaf,yaf,[0 0]',1);
k1=theta(1);
k2=theta(2);


