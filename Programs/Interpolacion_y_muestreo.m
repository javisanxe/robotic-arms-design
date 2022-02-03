function Muestreo = Interpolacion_y_muestreo(t,q,qp,delta,Tm,Treposo)

%Datos entrada:  
q;         %q (:,1)'  o q (:,2)'
qp;        %qp(:,1)'  o qp(:,2)'
t;         %t'
delta;
Tm;
Treposo;

N=length(q);

Muestreo=[];
clf
hold on
%q(t)=a+b(t-ti)+c(t-ti)^2+d(t-ti)^3  

%*****Correciones discontinuidades salto 0-360º trayectoria figura  ????
        qx=q;    %V.Auxiliares
        qpx=qp;
        
       
        for j=2:N-1
    
             if qx(j)-qx(j+1)>pi
        
             qx(j+1)=qx(j+1)+2*pi;
             end
    
             if qx(j+1)-qx(j)>pi
        
             qx(j+1)=qx(j+1)-2*pi;
             end
         
        end


%Calculo de coef. del polinomio cúbico para cada tramo entre 2 puntos 
%q(i)-----q(i+1)
for i=1:N-1
        
        if t(i+1)<=t(i)
            error ('ERROR : t(i+1)<t(i) ')
        end
        %Tiempo entre un punto y otro (En principio sera igual para todos por como lo hemos diseñado)
        T=t(i+1)-t(i);
      
        
        %Coeficientes Polinomio cúbico
        A(i)=qx(i);
        B(i)=qpx(i);
        C(i)=(3/(T^2)) * (qx(i+1)-qx(i))  -  (1/T)    * (qpx(i+1)+2*qpx(i));
        D(i)=(-2/(T^3))* (qx(i+1)-qx(i))  +  (1/(T^2))* (qpx(i+1)+qpx(i));
        
        Tiempos(:,i)=[t(i);t(i+1)];
end

clearvars qx qpx
 

 
 
%% Como ya hemos calculado los polinomios cúbicos para cada tramo entre cada dos puntos
%% Muestreamos trayectoria articular

%%REPOSO-ORIGEN
n_puntos_intermedios=Treposo/Tm;
    
    ti = Tiempos(1,1);                 
    tf = Tiempos(2,1);
    a  = A(1);
    b  = B(1);
    c  = C(1);
    d  = D(1);
    
    tincremento=(tf-ti)/n_puntos_intermedios;
    
    for tt=ti:tincremento:tf-tincremento
        
        %Posiciones muestreadas ------------------ q=a+b(t-ti)+c(t-ti)^2+d(t-ti)^3  
        qm=a+b*(tt-ti)+c*(tt-ti)^2+d*(tt-ti)^3; 
        %Velocidades muestreadas ----------------- qp=b+2c(t-ti)+3d(t-ti)^2     (Derivada posición)
        qpm=b+2*c*(tt-ti)+3*d*(tt-ti)^2;    
        %Aceleraciones muestreadas --------------- qpp=2c+6d(t-ti)              (Derivada velocidad)
        qppm=2*c+6*d*(tt-ti);                   
        
        plot(tt,qm,'k');
        
        Muestreo=[Muestreo;tt,qm,qpm,qppm];  %%Salida para una de las coord. articulares
    end
   


%%TRAMO DE LA FIGURA 

%Numero de puntos por cada tramo definido por una función cúbica
%(*Contando con los puntos inicial y final)

n_puntos_intermedios=delta/Tm;

for tramo=2:N-2  %%Quitando origen y fin (1 y N-1)
    
    ti = Tiempos(1,tramo);                 
    tf = Tiempos(2,tramo);
    a  = A(tramo);
    b  = B(tramo);
    c  = C(tramo);
    d  = D(tramo);
    
    tincremento=(tf-ti)/n_puntos_intermedios;
    
    for tt=ti:tincremento:tf-tincremento
        
        %Posiciones muestreadas ------------------ q=a+b(t-ti)+c(t-ti)^2+d(t-ti)^3  
        qm=a+b*(tt-ti)+c*(tt-ti)^2+d*(tt-ti)^3; 
        %Velocidades muestreadas ----------------- qp=b+2c(t-ti)+3d(t-ti)^2     (Derivada posición)
        qpm=b+2*c*(tt-ti)+3*d*(tt-ti)^2;    
        %Aceleraciones muestreadas --------------- qpp=2c+6d(t-ti)              (Derivada velocidad)
        qppm=2*c+6*d*(tt-ti);                   
        
        plot(tt,qm,'k');
        
        Muestreo=[Muestreo;tt,qm,qpm,qppm];  %%Salida para una de las coord. articulares
    end
   
end

%%FINAL-REPOSO

n_puntos_intermedios=Treposo/Tm;
    
    ti = Tiempos(1,N-1);                 
    tf = Tiempos(2,N-1);
    a  = A(N-1);
    b  = B(N-1);
    c  = C(N-1);
    d  = D(N-1);
    
    tincremento=(tf-ti)/n_puntos_intermedios;
    
    for tt=ti:tincremento:tf       %%%-tincremento
        
        %Posiciones muestreadas ------------------ q=a+b(t-ti)+c(t-ti)^2+d(t-ti)^3  
        qm=a+b*(tt-ti)+c*(tt-ti)^2+d*(tt-ti)^3; 
        %Velocidades muestreadas ----------------- qp=b+2c(t-ti)+3d(t-ti)^2     (Derivada posición)
        qpm=b+2*c*(tt-ti)+3*d*(tt-ti)^2;    
        %Aceleraciones muestreadas --------------- qpp=2c+6d(t-ti)              (Derivada velocidad)
        qppm=2*c+6*d*(tt-ti);                   
        
        plot(tt,qm,'k');
        
        Muestreo=[Muestreo;tt,qm,qpm,qppm];  %%Salida para una de las coord. articulares
    
    end
   

plot(t,q,'o')
grid
hold off


         
end

