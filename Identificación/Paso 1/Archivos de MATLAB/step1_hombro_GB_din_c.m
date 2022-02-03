%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funci�n para la estimaci�n de k5

% La funci�n emplea el procedimiento descrito como paso 1  del
% procedimiento de identificaci�n de fricci�n de LUGRE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [k5,error]=step1_hombro_GB_din_c(Phic_mdl,yc_mdl)

% Articulaci�n del Hombro
n=size(Phic_mdl,1);
nsamp=2e4; % Se toman �nicamente las nsamp �ltimas muestras
if n-nsamp<1
    samp_inic=1; 
else
    samp_inic=n-nsamp;
end
cont=1;
Phicf={};
ycf={};

for i=samp_inic:n
    Phicf{cont}=Phic_mdl(i,:)';
    ycf{cont}=yc_mdl(i,1);
    cont=cont+1;
end

[theta,error]=ewrls(Phicf,ycf,[0]',1);
k5=theta(1);



