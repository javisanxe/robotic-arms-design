
% ARCHIVO QUE PREPARA LOS DATOS DE POSICIÓN OBTENIDOS EN EL EXPERIMENTO,
% CALCULANDO NUMÉRICAMENTE LA VELOCIDAD Y LA ACELERACIÓN 

% DEBE EJECUTARSE CONSCIENTEMENTE A PARTIR DE UN ARCHIVO DE DATOS DE
% NOMBRE: Posicion_Ident_friccion_STEP3_linkX_vY, siendo X el número de la
% articulación (1=hombro,2_codo), y Y el número de experimento. 
% NO SE EJECUTA COMO CALLBACK DEL MODELO, ES UN ALGORITMO QUE DEBE
% EJECUTARSE FUERA DE LÍNEA

% FINALMENTE GUARDA LOS DATOS NECESARIOS PARA APLICAR DIRECTAMENTE EL        
% STEP 3 EN UN ARCHIVO DE NOMBRE: DATA_Ident_friccion_STEP3_linkX_vY, donde
% X e Y tienen el mismo significado y valor que en el archivo anterior.


clear all
close all
clc

disp('IDENTIFICACIÓN DE FRICCIÓN DE LUGRE, STEP 3');

nlink = input('\nIntroduzca el número de la articulación a identificar\n(1=Hombro, 2=Codo)? ','s');
nens = input('\n Número de la sesión de datos para importar? ','s');
numlink=str2num(nlink);
numens=str2num(nens);
disp(' ')
name=strcat('Posicion_Ident_friccion_STEP3_link',nlink,'_v',nens,'.mat');
load(name);


disp('FASE I:')
disp(' ')
disp('DETECCIÓN DE OFFSET (FUNCIÓN DE HOMING)')

switch str2num(nlink)
    case 1
        instante_hombro = primer_valor_no_nulo(offset_h);
        disp('El offset del hombro es')
        disp(offset_h(instante_hombro))
        n_h = length(offset_h)-instante_hombro+1;
        q_step3_aux(1:n_h,:) = q_step3(instante_hombro:end,:);
        clear q_step3
        q_step3 = q_step3_aux;
        u_step3_aux(1:n_h,:) = u_step3(instante_hombro:end,:);
        clear u_step3
        u_step3 = u_step3_aux;
        t_aux(1:n_h,:) = t(instante_hombro:end,:);
        clear t
        t = t_aux;
   
    case 2
        instante_codo = primer_valor_no_nulo(offset_c);
        disp('El offset del codo es')
        disp(offset_c(instante_codo))
        n_c = length(offset_c)-instante_codo+1;
        q_step3_aux(1:n_c,:) = q_step3(instante_codo:end,:);
        clear q_step3
        q_step3 = q_step3_aux;
        u_step3_aux(1:n_c,:) = u_step3(instante_codo:end,:);
        clear u_step3
        u_step3 = u_step3_aux;
        t_aux(1:n_c,:) = t(instante_codo:end,:);
        clear t
        t = t_aux;
    otherwise
        disp('No ha seleccionado una articulación válida');
end


disp('FASE II:')
disp(' ')
disp('DERIVACIÓN NUMÉRICA DE LA POSICIÓN, OBTENCIÓN DE VELOCIDAD Y ACELERACIÓN')

%*******Velocidad SG******************************************************************

delta = 0.001;   % Tiempo de muestreo de xPC Target

nR=50;
nL=50;
c=sgfilter(nL,nR,5,1);
l=size(q_step3,1);
qp_sg=zeros(l,2);

for i=nL+1:l-nR
    s=0;
    for j=-nL:nR
        s=s+c(j+nL+1)*q_step3(i+j,numlink);
    end
    qp_sg(i,numlink)=s/delta;
end

%********Aceleración SG*****************************************************************
nR=50;
nL=50;
c=sgfilter(nL,nR,2,2);
l=size(q_step3,1);
qpp_sg=zeros(l,2);

for i=nL+1:l-nR
    s=0;
    for j=-nL:nR
        s=s+c(j+nL+1)*q_step3(i+j,numlink);
    end
    %qpp_sg(i,numlink)=s/(delta*delta);
    qpp_sg(i,numlink)=2*s/(delta*delta);
end

% Representación de los resultados:

switch numlink
    
    case 1
        
        figure(1);
        %plot(t,q_step3(:,1),'b-',t,qp_sg(:,1),'r-',t,qpp_sg(:,1),'m-');
        plot(t,q_step3(:,1),'b-',t,qp_sg(:,1),'r-');
        grid on;
        xlabel('Tiempo (s)');
        %legend('Posición (rad)','Velocidad numérica (sg) (rad/s)','Aceleración numérica (rad/s2)');
        legend('Posición (rad)','Velocidad numérica (sg) (rad/s)');
        title('HOMBRO');         
        
        figure(2);
        plot(t,u_step3(:,1),'b-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Señal de control');
        title('HOMBRO');      
        
        figure(3);
        plot(t,qpp_sg(:,1),'b-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Aceleración (rad/s2)');
        title('HOMBRO'); 
        
        figure(4);
        plot(t,q_step3(:,1),'b-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Posición (rad)');
        title('HOMBRO'); 

    case 2
        
        figure(1);
        %plot(t,q_step3(:,2),'b-',t,qp_sg(:,2),'r-',t,qpp_sg(:,2),'m-');
        plot(t,q_step3(:,2),'b-',t,qp_sg(:,2),'r-');
        grid on;
        xlabel('Tiempo (s)');
        %legend('Posición (rad)','Velocidad numérica (sg) (rad/s)','Aceleración numérica (rad/s2)');
        legend('Posición (rad)','Velocidad numérica (sg) (rad/s)');
        title('CODO');         
        
        figure(2);
        plot(t,u_step3(:,2),'b-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Señal de control');
        title('CODO'); 
        
        figure(3);
        plot(t,qpp_sg(:,2),'b-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Aceleración (rad/s2)');
        title('CODO'); 
        
        figure(4);
        plot(t,q_step3(:,2),'b-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Posición (rad)');
        title('CODO'); 
                
    otherwise
        
        disp('No ha seleccionado una articulación válida');
        
end



% Elección definitiva del método de derivación:

qp_step3 = qp_sg;
qpp_step3 = qpp_sg;



disp('FASE III:')
disp(' ')
disp('ALMACENAMIENTO DE DATOS NECESARIOS PARA EL STEP 3')


name2=strcat('DATA_Ident_friccion_STEP3_link',nlink,'_v',nens,'.mat');

save (name2,'t','q_step3','u_step3','qp_step3','qpp_step3');

disp(' ');
disp('Datos de identificación necesarios para el step 3 guardados en');
disp(name2);





