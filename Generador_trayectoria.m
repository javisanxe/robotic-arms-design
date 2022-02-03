function out=Generador_trayectoria(in)
%La función va a devolver 3 vectores que van a ser qr qdr y qddr.

% A la función le van a entrar los parametros:
Xini        = in(1);
Yini        = in(2);

Xfin        = in(3);
Yfin        = in(3);

N           = in(5); %Numero de puntos intermedios
Tinicio     = in(6); %Tiempo que tarda en empezar a moverse el robot
Duracion    = in(7); %Tiempo del movimiento del robot
Tiempo      = in(8);

% Parámetros Geométricos Brazo
L1=0.45;
L2=0.45;


%X: vector que contiene las coordenadas x del movimiento del robot
%Y: vector que contiene las coordenadas y del movimiento del robot

% Tiempo total
ttotal=Tinicio+Duracion; 
% Tiempo de duración de cada tramo : ttramo=ttotal/(N+1);
ttramo=Duracion/(N+1);

% Posición del punto inicial
    X(1)=Xini;
    Y(1)=Yini;
    
% Posición del punto final
    X(N+2)=Xfin;
    Y(N+2)=Yfin;
    

% Vectores con los valores de las coordenadas articulares
q1=zeros(N);
q2=zeros(N);


% Puntos intermedios
for i=1:(N+1)
    %Recorrido lineal entre puntos
    X(i)=Xini+((Xfin-Xini)*(i-1)/(N+1)) ;
    Y(i)=Yini+((Yfin-Yini)*(i-1)/(N+1)) ;
    
end   

% Cinemática inversa de todos los puntos incluidos el inicial y el final
for i=1:(N+2)
    
    beta   = atan2(Y(i),X(i));
    cos_q2 = (X(i)^2+Y(i)^2-L1^2-L2^2)/(2*L1*L2);
    sen_q2 =  sqrt(1-cos_q2^2);
    
    alfa   = atan2(L2*sen_q2,L1+L2*cos_q2);
    
    %CINEMATICA INVERSA
    q1(i) = atan2(Y(i),X(i)) - alfa;
    q2(i) = atan2(sen_q2,cos_q2);

end


% Para el primer y ultimo punto las vecocidades son 0
qp1(1)=0;
qp2(1)=0;

qp1(N+2)=0;
qp2(N+2)=0;


%Las aceleraciones son 0
%qpp1=0;
%qpp2=0;


% Calculamos las velocidades en el resto de puntos: CRITERIO HEURÍSTICO
for i=2:(N+1)
    Tiniciotramo=Tinicio+ttramo*(i-1);  %Tiempo en el que se inicia el tramo de la articulacion i
    Tfintramo=Tiniciotramo+ttramo;      %Tiempo en el que acaba el tramo de la articulacion i, coincide con el inicio de la i+1
    Ttramoanterior=Tiniciotramo-ttramo; %Tiempo en el que empieza el tramo de la articulacion i-1
    
    % Para la primera articulación
    if (sign(q1(i)-q1(i-1))~= sign(q1(i+1)-q1(i)))
            qp1(i)=0; 
    elseif (sign(q1(i)-q1(i-1))== sign(q1(i+1)-q1(i)))
            qp1(i) = 0.5*(((q1(i+1)-q1(i))/(Tfintramo-Tiniciotramo)) + ((q1(i)-q1(i-1))/(Tiniciotramo-Ttramoanterior)));
    elseif (q1(i-1)==q1(i))
            qp1(i) = 0.5*(((q1(i+1)-q1(i))/(Tfintramo-Tiniciotramo)) + ((q1(i)-q1(i-1))/(Tiniciotramo-Ttramoanterior)));
    elseif (q1(i+1)==q1(i))
            qp1(i) = 0.5*(((q1(i+1)-q1(i))/(Tfintramo-Tiniciotramo)) + ((q1(i)-q1(i-1))/(Tiniciotramo-Ttramoanterior)));        
    else
            qp1(i)=0;
    end
    
    %Para la segunda articulación
    if (sign(q2(i)-q2(i-1))~= sign(q2(i+1)-q2(i)))
            qp2(i)=0;
    elseif (sign(q2(i)-q2(i-1))== sign(q2(i+1)-q2(i)))
            qp2(i) = 0.5*(((q2(i+1)-q2(i))/(Tfintramo-Tiniciotramo)) + ((q2(i)-q2(i-1))/(Tiniciotramo-Ttramoanterior)));
    elseif (q2(i-1)==q2(i))
            qp2(i) = 0.5*(((q2(i+1)-q2(i))/(Tfintramo-Tiniciotramo)) + ((q2(i)-q2(i-1))/(Tiniciotramo-Ttramoanterior)));
    elseif (q2(i+1)==q2(i))
            qp2(i) = 0.5*(((q2(i+1)-q2(i))/(Tfintramo-Tiniciotramo)) + ((q2(i)-q2(i-1))/(Tiniciotramo-Ttramoanterior)));    
    else
            qp2(i)=0; 
    end
    
end

% Interpolador cúbico

if(Tiempo<=Tinicio)
 
    beta   = atan2(Yini,Xini);
    cos_q2 = (Xini^2+Yini^2-L1^2-L2^2)/(2*L1*L2);
    sen_q2 =  sqrt(1-cos_q2^2);
    
    alfa   = atan2(L2*sen_q2,L1+L2*cos_q2);
    
    %CINEMATICA INVERSA
    q1t = atan2(Yini,Xini) - alfa;
    q2t = atan2(sen_q2,cos_q2);
    
     
    qd1t=0;
    qd2t=0;
   
    qdd1t=0;
    qdd2t=0;
           
end
    
if(Tiempo>=Tinicio && Tiempo<Tinicio+Duracion)
    for i=1:(N+1)

        Tiniciotramo=Tinicio+ttramo*(i-1); %Tiempo en el que se inicia el tramo de la articulacion i
        Tfintramo=Tiniciotramo+ttramo;
        T=ttramo;

        if(Tiempo>Tiniciotramo && Tiempo<Tfintramo)

            %Calculamos los coeficientes
            a1=q1(i);
            b1=qp1(i);
            c1=(3/(T^2))*(q1(i+1)-q1(i))-(1/T)*(qp1(i+1)+(2*qp1(i)));
            d1=(-2/(T^3))*(q1(i+1)-q1(i))+(1/(T^2))*(qp1(i+1)+qp1(i));

            a2=q2(i);
            b2=qp2(i);
            c2=(3/(T^2))*(q2(i+1)-q2(i))-(1/T)*(qp2(i+1)+(2*qp2(i)));
            d2=(-2/(T^3))*(q2(i+1)-q2(i))+(1/(T^2))*(qp2(i+1)+qp2(i));

            %Calculamos las posiciones
            q1t = a1 + (b1*(Tiempo-(Tiniciotramo))) + (c1*(Tiempo-(Tiniciotramo))^2) + (d1*(Tiempo-(Tiniciotramo))^3);
            q2t = a2 + (b2*(Tiempo-(Tiniciotramo))) + (c2*(Tiempo-(Tiniciotramo))^2) + (d2*(Tiempo-(Tiniciotramo))^3);
          
            %Calculamos las velocidades
            qd1t = b1 + 2*c1*(Tiempo-(Tiniciotramo)) + 3*d1*(Tiempo-(Tiniciotramo))^2;
            qd2t = b2 + 2*c2*(Tiempo-(Tiniciotramo)) + 3*d2*(Tiempo-(Tiniciotramo))^2;
            
            %Calculamos las aceleraciones
            qdd1t = 2*c1 + 6*d1*(Tiempo-(Tiniciotramo));
            qdd2t = 2*c2 + 6*d2*(Tiempo-(Tiniciotramo));
            
        end
    end
end

if(Tiempo>=Tinicio+Duracion)

    beta   = atan2(Yfin,Xfin);
    cos_q2 = (Xfin^2+Yfin^2-L1^2-L2^2)/(2*L1*L2);
    sen_q2 =  sqrt(1-cos_q2^2);
    
    alfa   = atan2(L2*sen_q2,L1+L2*cos_q2);
    
    %CINEMATICA INVERSA
    q1t = atan2(Yfin,Xfin) - alfa;
    q2t = atan2(sen_q2,cos_q2);%Ecuaciones cinemática inversa
    
    qd1t=0;
    qd2t=0;
        
    qdd1t=0;
    qdd2t=0;
        
end

out=[q1t;q2t;qd1t;qd2t;qdd1t;qdd2t];