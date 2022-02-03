
% ARCHIVO QUE PREPARA LOS DATOS DE POSICI�N OBTENIDOS EN EL EXPERIMENTO,
% CALCULANDO NUM�RICAMENTE LA VELOCIDAD 

% DEBE EJECUTARSE CONSCIENTEMENTE A PARTIR DE UN ARCHIVO DE DATOS DE
% NOMBRE: Posicion_Ident_friccion_STEP2_linkX_vY, siendo X el n�mero de la
% articulaci�n (1=hombro,2_codo), y Y el n�mero de experimento. 
% NO SE EJECUTA COMO CALLBACK DEL MODELO, ES UN ALGORITMO QUE DEBE
% EJECUTARSE FUERA DE L�NEA

% FINALMENTE GUARDA LOS DATOS NECESARIOS PARA APLICAR DIRECTAMENTE EL        
% STEP 2 EN UN ARCHIVO DE NOMBRE: DATA_Ident_friccion_STEP2_linkX_vY, donde
% X e Y tienen el mismo significado y valor que en el archivo anterior.


clear all
close all
clc

disp('IDENTIFICACI�N DE FRICCI�N DE LUGRE, STEP 2');

nlink = input('\nIntroduzca el n�mero de la articulaci�n a identificar\n(1=Hombro, 2=Codo)? ','s');
nens = input('\n N�mero de la sesi�n de datos para importar? ','s');
numlink=str2num(nlink);
numens=str2num(nens);
disp(' ')
name=strcat('Posicion_Ident_friccion_STEP2_link',nlink,'_v',nens,'.mat');
load(name);


disp('FASE I:')
disp(' ')
disp('DETECCI�N DE OFFSET (FUNCI�N DE HOMING)')

switch str2num(nlink)
    case 1
        instante_hombro = primer_valor_no_nulo(offset_h);
        disp('El offset del hombro es')
        disp(offset_h(instante_hombro))
        %instante_hombro = 15000;
        n_h = length(offset_h)-instante_hombro+1;
        q_step2_aux(1:n_h,:) = q_step2(instante_hombro:end,:);
        clear q_step2
        q_step2 = q_step2_aux;
        u_step2_aux(1:n_h,:) = u_step2(instante_hombro:end,:);
        clear u_step2
        u_step2 = u_step2_aux;
        u_se_step2_aux(1:n_h,:) = u_se_step2(instante_hombro:end,:);
        clear u_se_step2
        u_se_step2 = u_se_step2_aux;
        t_aux(1:n_h,:) = t(instante_hombro:end,:);
        clear t
        t = t_aux;
   
    case 2
        instante_codo = primer_valor_no_nulo(offset_c);
        disp('El offset del codo es')
        disp(offset_c(instante_codo))
        %instante_codo = 2000;
        n_c = length(offset_c)-instante_codo+1;
        q_step2_aux(1:n_c,:) = q_step2(instante_codo:end,:);
        clear q_step2
        q_step2 = q_step2_aux;
        u_step2_aux(1:n_c,:) = u_step2(instante_codo:end,:);
        clear u_step2
        u_step2 = u_step2_aux;
        u_se_step2_aux(1:n_c,:) = u_se_step2(instante_codo:end,:);
        clear u_se_step2
        u_se_step2 = u_se_step2_aux;
        t_aux(1:n_c,:) = t(instante_codo:end,:);
        clear t
        t = t_aux;
    otherwise
        disp('No ha seleccionado una articulaci�n v�lida');
end


disp('FASE II:')
disp(' ')
disp('DERIVACI�N NUM�RICA DE LA POSICI�N, OBTENCI�N DE VELOCIDAD')

%*******Velocidad SG******************************************************************

delta = 0.001;   % Tiempo de muestreo de xPC Target

nR=50;
nL=50;
c=sgfilter(nL,nR,5,1);
l=size(q_step2,1);
qp_sg=zeros(l,2);

for i=nL+1:l-nR
    s=0;
    for j=-nL:nR
        s=s+c(j+nL+1)*q_step2(i+j,numlink);
    end
    qp_sg(i,numlink)=s/delta;
end



% % Representaci�n de los resultados:
% 
% switch numlink
%     
%     case 1
%         
%         figure(1);
%         plot(t,q_step2(:,1),'b-',t,qp_sg(:,1),'r-');
%         grid on;
%         xlabel('Tiempo (s)');
%         legend('Posici�n (rad)','Velocidad num�rica (sg) (rad/s)');
%         title('HOMBRO');         
% 
%     case 2
%         
%         figure(1);
%         plot(t,q_step2(:,2),'b-',t,qp_sg(:,2),'r-');
%         grid on;
%         xlabel('Tiempo (s)');
%         legend('Posici�n (rad)','Velocidad num�rica (sg) (rad/s)');
%         title('CODO');         
%                 
%     otherwise
%         
%         disp('No ha seleccionado una articulaci�n v�lida');
%         
% end

% Elecci�n definitiva del m�todo de derivaci�n:

qp_step2 = qp_sg;

% Representaci�n del ciclo l�mite de Hunting:

figure(2);
plot(t,q_step2(:,numlink),'g-',t,u_step2(:,numlink),'b-',t,u_se_step2(:,numlink),'r-');
grid on;
xlabel('Tiempo (s)');
legend('Posici�n (rad)','Se�al de control real','Se�al de control parcial y filtrada');
title('Ciclo l�mite de Hunting');



disp('FASE III:')
disp(' ')
disp('ALMACENAMIENTO DE DATOS NECESARIOS PARA EL STEP 2')


name2=strcat('DATA_Ident_friccion_STEP2_link',nlink,'_v',nens,'.mat');

save (name2,'t','q_step2','u_step2','qp_step2','u_se_step2');

disp(' ');
disp('Datos de identificaci�n necesarios para el step 2 guardados en');
disp(name2);





