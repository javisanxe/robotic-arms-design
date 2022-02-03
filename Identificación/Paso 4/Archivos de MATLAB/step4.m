%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Función para la estimación de:

% sigma0 
% sigma1 


% La función emplea el procedimiento descrito como STEP 4 del
% procedimiento de identificación de fricción de LUGRE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [sigma0,sigma1]=step4(q,u,J,sigma2)

n=size(q,1);
nsamp=5e3; % Se toman únicamente las nsamp últimas muestras
if n-nsamp<1
    samp_inic=1; 
else
    samp_inic=n-nsamp;
end
cont=1;
Phif={};
yf={};

for i=samp_inic:n
    Phif{cont}=q(i);
    yf{cont}=u(i);
    cont=cont+1;
end

[theta,error]=ewrls(Phif,yf,[0]',1);

sigma0=theta;

sigma1=2*sqrt(sigma0*J)-sigma2;
