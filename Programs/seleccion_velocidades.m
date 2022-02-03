function qp = seleccion_velocidades(q,t)
%% Criterios de velocidad  (Necesitamos calcular las velocidades con algun método) 
%Datos partida:
q;
t;

if length(q)~=length(t)
    error('q y t deben tener el mismo nº datos')
end


%*****Correciones discontinuidades salto 0-360º trayectoria figura  ????
for k=1:2
for j=2:length(t)-2
    
    if q(j,k)-q(j+1,k)>pi
        
        q(j+1,k)=q(j+1,k)+2*pi;
    end
    
    if q(j+1,k)-q(j,k)>pi
        
        q(j+1,k)=q(j+1,k)-2*pi;
    end
end
end
    

% %1.-CRITERIO HEURÍSTICO: Velocidad valor 0 o valor medio de las v.lineales
% %---Entrada: q,t   ----Salida: qp
% longitud=length(t)
% qp=zeros(longitud,2);
% 
% for i=2:1:longitud-1
%     for k=1:2
%         
%        if ((sign(q(i,k)-q(i-1,k))==sign(q(i+1,k)-q(i,k))) || (q(i,k)-q(i-1,k))==0 || (q(i+1,k)-q(i,k))==0)
%     
%             qp(i,k)=0.5*(((q(i+1,k)-q(i,k))/(t(i+1)-t(i)))+((q(i,k)-q(i-1,k))/(t(i)-t(i-1))));
%        else
%             qp(i,k)=0;
%        end 
%     end
% end
% % qp(longitud,1)=0;  %Creo que no hace falta ponerlo
% % qp(longitud,2)=0;  %Creo que no hace falta ponerlo

%2.-CRITERIO CONTINUIDAD ACELERACIONES: Resolver sistema de ecuaciones con
%todas las velocidades de la trayectoria de forma simultánea:

%---Entrada: q,t ------Salida:qp
longitud = length(t);
qp = zeros(longitud,2);

A = zeros(longitud);
B = zeros(longitud,1);

for k = 1:size(q,2),
    
    A(1,1) = 1;
    
    for i=2:longitud-1,
        
        %*Correciones discontinuidades salto 0-360º
        
        
        A(i,i-1)= ((t(i+1,1)-t(i,1))^2)*(t(i,1)-t(i-1,1));
        A(i,i) = 2*((t(i+1,1)^2)*t(i,1) - (t(i,1)^2)*t(i+1,1) + (t(i-1,1)^2)*t(i+1,1) - (t(i+1,1)^2)*t(i-1,1) + (t(i,1)^2)*t(i-1,1) - (t(i-1,1)^2)*t(i,1));
        A(i,i+1) = (t(i+1,1)-t(i,1))*((t(i,1)-t(i-1,1))^2);
        
        k1 = - ((t(i+1,1)-t(i,1))^2);
        k2 = (t(i+1,1)^2) - (t(i-1,1)^2) + 2*t(i,1)*t(i-1,1) - 2*t(i,1)*t(i+1,1);
        k3 = ((t(i,1)-t(i-1,1))^2); 
        
        B(i,1) = 3*(k1*q(i-1,k) + k2*q(i,k) + k3*q(i+1,k));
    end

    A(longitud,longitud) = 1;
   
    qp(1:longitud,k) = A\B;  %%A*qp=B

    
end

%3.-CRITERIO MEDIANTE JACOBIANA (VELOCIDADES ESPACIO TAREA??)
% J= [-L1*sin(q(,1)) -L2*sin(q(,1)+q(,2));
% 
%      L1*cos(q(,1)) +L2*cos(q(,1)+q(,2))]
%  
%  qp=(J^-1)*xp=
%-----
%REPRESENTACIÓN Y COMPARACIÓN DE LOS DIFERENTES CRITERIOS
end

