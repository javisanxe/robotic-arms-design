
% ARCHIVO QUE PREPARA LOS DATOS DE POSICI�N OBTENIDOS EN EL EXPERIMENTO,
% CALCULANDO NUM�RICAMENTE LA VELOCIDAD Y LA ACELERACI�N 

% DEBE EJECUTARSE CONSCIENTEMENTE A PARTIR DE UN ARCHIVO DE DATOS DE
% NOMBRE: Posicion_Ident_friccion_STEP3_linkX_vY, siendo X el n�mero de la
% articulaci�n (1=hombro,2_codo), y Y el n�mero de experimento. 
% NO SE EJECUTA COMO CALLBACK DEL MODELO, ES UN ALGORITMO QUE DEBE
% EJECUTARSE FUERA DE L�NEA

% FINALMENTE GUARDA LOS DATOS NECESARIOS PARA APLICAR DIRECTAMENTE EL        
% STEP 3 EN UN ARCHIVO DE NOMBRE: DATA_Ident_friccion_STEP3_linkX_vY, donde
% X e Y tienen el mismo significado y valor que en el archivo anterior.


clear all
close all
clc

disp('IDENTIFICACI�N DE FRICCI�N DE LUGRE, STEP 3');

nlink = input('\nIntroduzca el n�mero de la articulaci�n a identificar\n(1=Hombro, 2=Codo)? ','s');
nens = input('\n N�mero de la sesi�n de datos para importar? ','s');
numlink=str2num(nlink);
numens=str2num(nens);
disp(' ')
name=strcat('Posicion_Ident_friccion_STEP3_link',nlink,'_v',nens,'.mat');
load(name);


disp('FASE I:')
disp(' ')
disp('DETECCI�N DE OFFSET (FUNCI�N DE HOMING)')

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
        disp('No ha seleccionado una articulaci�n v�lida');
end


disp('FASE II:')
disp(' ')
disp('DERIVACI�N NUM�RICA DE LA POSICI�N, OBTENCI�N DE VELOCIDAD Y ACELERACI�N')

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

%********Aceleraci�n SG*****************************************************************
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

% Representaci�n de los resultados:

switch numlink
    
    case 1
        
        figure(1);
        %plot(t,q_step3(:,1),'b-',t,qp_sg(:,1),'r-',t,qpp_sg(:,1),'m-');
        plot(t,q_step3(:,1),'b-',t,qp_sg(:,1),'r-');
        grid on;
        xlabel('Tiempo (s)');
        %legend('Posici�n (rad)','Velocidad num�rica (sg) (rad/s)','Aceleraci�n num�rica (rad/s2)');
        legend('Posici�n (rad)','Velocidad num�rica (sg) (rad/s)');
        title('HOMBRO');         
        
        figure(2);
        plot(t,u_step3(:,1),'b-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Se�al de control');
        title('HOMBRO');      
        
        figure(3);
        plot(t,qpp_sg(:,1),'b-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Aceleraci�n (rad/s2)');
        title('HOMBRO'); 
        
        figure(4);
        plot(t,q_step3(:,1),'b-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Posici�n (rad)');
        title('HOMBRO'); 

    case 2
        
        figure(1);
        %plot(t,q_step3(:,2),'b-',t,qp_sg(:,2),'r-',t,qpp_sg(:,2),'m-');
        plot(t,q_step3(:,2),'b-',t,qp_sg(:,2),'r-');
        grid on;
        xlabel('Tiempo (s)');
        %legend('Posici�n (rad)','Velocidad num�rica (sg) (rad/s)','Aceleraci�n num�rica (rad/s2)');
        legend('Posici�n (rad)','Velocidad num�rica (sg) (rad/s)');
        title('CODO');         
        
        figure(2);
        plot(t,u_step3(:,2),'b-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Se�al de control');
        title('CODO'); 
        
        figure(3);
        plot(t,qpp_sg(:,2),'b-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Aceleraci�n (rad/s2)');
        title('CODO'); 
        
        figure(4);
        plot(t,q_step3(:,2),'b-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Posici�n (rad)');
        title('CODO'); 
                
    otherwise
        
        disp('No ha seleccionado una articulaci�n v�lida');
        
end



% Elecci�n definitiva del m�todo de derivaci�n:

qp_step3 = qp_sg;
qpp_step3 = qpp_sg;



disp('FASE III:')
disp(' ')
disp('ALMACENAMIENTO DE DATOS NECESARIOS PARA EL STEP 3')


name2=strcat('DATA_Ident_friccion_STEP3_link',nlink,'_v',nens,'.mat');

save (name2,'t','q_step3','u_step3','qp_step3','qpp_step3');

disp(' ');
disp('Datos de identificaci�n necesarios para el step 3 guardados en');
disp(name2);





