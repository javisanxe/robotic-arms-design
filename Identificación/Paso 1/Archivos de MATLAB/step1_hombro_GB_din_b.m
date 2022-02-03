%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funci�n para la estimaci�n de k4 y k5

% La funci�n emplea el procedimiento descrito como paso 1  del
% procedimiento de identificaci�n de fricci�n de LUGRE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [k4,k5,error]=step1_hombro_GB_din_b(Phib_mdl,yb_mdl)

% Articulaci�n del Hombro
n=size(Phib_mdl,1);
nsamp=2e4; % Se toman �nicamente las nsamp �ltimas muestras
if n-nsamp<1
    samp_inic=1; 
else
    samp_inic=n-nsamp;
end
cont=1;
Phibf={};
ybf={};

for i=samp_inic:n
    Phibf{cont}=Phib_mdl(i,:)';
    ybf{cont}=yb_mdl(i,1);
    cont=cont+1;
end

[theta,error]=ewrls(Phibf,ybf,[0 0]',1);
k4=theta(1);
k5=theta(2);


