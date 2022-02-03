% Programa de 'filtrado' de par para la obtenci�n de la fricci�n est�tica

% Calcula los m�ximos y m�nimos locales y obtiene la fricci�n est�tica
% positiva y negativa mediante promediado

function [Fsmas_est,Fsmenos_est]=step2(x)
nmax=5; % N�mero de m�ximos a filtrar
%calculamos los pasos por cero de la se�al
x0=find(-0.05 < x & x < 0.05);
n=size(x0,1);
x0_ant=x0(1);
vx0=[x0_ant];
for i=2:n
    if(x0(i)-x0_ant~=1)
        vx0=[vx0 x0(i)];
    end
    x0_ant=x0(i);
end
n2=size(vx0,2);
vmax=[];
vmin=[];
for i=1:n2-1
    aux_max=max(x(vx0(i):vx0(i+1)));
    aux_min=min(x(vx0(i):vx0(i+1)));
%     vmin=[vmin aux_min];
%     vmax=[vmax aux_max];
    if(abs(aux_max)<abs(aux_min))
        vmin=[vmin abs(aux_min)];
    else
        vmax=[vmax aux_max];
    end
end
Fsmas_est=mean(vmax);
Fsmenos_est=mean(vmin);
    
    
    