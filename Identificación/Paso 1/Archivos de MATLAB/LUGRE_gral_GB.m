% Programa principal para el cálculo integrado de los parámetros de
% fricción del modelo LUGRE para cada una de las articulaciones del robot
% de dos grados de libertad

% DESCRIPCIÓN:
% El programa requiere obtener resultados experimentales en 4 fases
% diferenciadas (o STEPs). Se dispone de cuatro modelos de SIMULINK
% denominados 'Ident_friccion_stepX_GB.mdl', donde X es el número de la etapa
% de identificación.
% Es necesario por tanto ejecutar cada uno de los modelos secuencialmente
% para el cálculo de todas las constantes. Los resultados experimentales
% son almacenados en ficheros denominados 'DATA_Ident_friccion_STEPX_vY.mat'
% donde X es la etapa de identificación, e Y el número del ensayo.


% STEP1
%clc
clear all

previo_LUGRE_gral_GB

disp('IDENTIFICACIÓN DE FRICCIÓN DE LUGRE');
nstep=input('Etapa de identificación (STEP 1 a 4)? ','s');
nlink = input('\nIntroduzca el número de la articulación a identificar\n(1=Hombro, 2=Codo)? ','s');
nens = input('\n Número de la sesión de datos para importar? ','s');
numlink=str2num(nlink);
numens=str2num(nens);
disp(' ')
               
switch str2num(nstep)
    case 1
        disp('- STEP 1 -------------------------------------------------------');
        disp('(Identificación de parámetros dinámicos, Fc y sigma2)');
        name=strcat('DATA_Ident_friccion_STEP1_link',nlink,'_v',nens,'.mat');
        load(name);
        
        nR=50;
        nL=50;
        n=size(q_step1,1);
        % Filtro de par para STEP 2
%         fs2=tf([1],[tau_Fs 1]);
%         mfs2=eye(2)*fs2;
        if numlink==1
            %[ka_id,kb_id,kc_id,Fc_id(numlink),sigma2_id(numlink),error_step1{numlink}]=step1_hombro_GB(Phi1_mdl,y1_mdl,qp_step1,numlink);
            [ka_id,kb_id,kc_id,Fc_id(numlink),sigma2_id(numlink),error_step1{numlink}]=step1_hombro_GB(Phi1_mdl(nL+1:n-nR,:),y1_mdl(nL+1:n-nR,:),qp_step1(nL+1:n-nR,:),numlink);
            s=sprintf('Datos identificados para la articulación %d\n\nka = %f\nkb = %f\nkc = %f\nFc(%d) = %f\nsigma2(%d) = %f\n',numlink,ka_id,kb_id,kc_id,numlink,Fc_id(numlink),numlink,sigma2_id(numlink));
            disp(s);
            [Kp1,Ki1,T1]=PI_hunting(ka_id,sigma2_id(1),Fc_id(1));
        elseif numlink==2
            %[k3_id,k5_id,Fc_id(numlink),sigma2_id(numlink),error_step1{numlink}]=step1_codo_GB(Phi2_mdl,y2_mdl,qp_step1,numlink);
            [k3_id,k5_id,Fc_id(numlink),sigma2_id(numlink),error_step1{numlink}]=step1_codo_GB(Phi2_mdl(nL+1:n-nR,:),y2_mdl(nL+1:n-nR,:),qp_step1(nL+1:n-nR,:),numlink);
            s=sprintf('Datos identificados para la articulación %d\n\nk3 = %f\nk5 = %f\nFc(%d) = %f\nsigma2(%d) = %f\n',numlink,k3_id,k5_id,numlink,Fc_id(numlink),numlink,sigma2_id(numlink));
            disp(s);
            [Kp2,Ki2,T2]=PI_hunting(k3_id,sigma2_id(2),Fc_id(2));
        end
        %s=sprintf('Datos identificados para la articulación %d\n\nJ(%d) = %f\nexc(%d) = %f\nFc(%d) = %f\nsigma2(%d) = %f\n',numlink,numlink,J(numlink),numlink,Fc(numlink),numlink,exc(numlink),numlink,sigma2(numlink));
        %s=sprintf('Datos identificados para la articulación %d\n\nJ(%d) = %f\nexc(%d) = %f\nFc(%d) = %f\nsigma2(%d) = %f\n',numlink,numlink,J(numlink),numlink,Fc(numlink),numlink,exc(numlink),numlink,sigma2(numlink));
        %disp(s);
        disp('Se han ajustado los valores del PI para fenómeno de Hunting');
        disp('Ahora puede ejecutar los ensayos de STEP 2');
        
    case 2

        disp('- STEP 2 -------------------------------------------------------');
        disp('(Identificación de Fs)');
        name=strcat('DATA_Ident_friccion_STEP2_link',nlink,'_v',nens,'.mat');
        load(name);
        [Fsmas_id(numlink),Fsmenos_id(numlink)]=step2(u_se_step2.signals.values(:,numlink));
        Fs_id(numlink)=(Fsmas_id(numlink)+Fsmenos_id(numlink))/2;
        s=sprintf('Datos identificados para la articulación %d\n\nFsmas(%d) = %f\nFsmenos(%d) = %f\n',numlink,numlink,Fsmas_id(numlink),numlink,Fsmenos_id(numlink));
        disp(s);
        disp('Ahora puede ejecutar los ensayos de STEP 3');
    case 3
        disp('- STEP 3 -------------------------------------------------------');
        disp('(Identificación de vs)');
        name=strcat('DATA_Ident_friccion_STEP3_link',nlink,'_v',nens,'.mat');
        load(name);
        if numlink==1
            [vs_id(numlink)]=step3(qp_step3(:,numlink),qpp_step3(:,numlink),u_step3.signals.values(:,numlink),ka_id,Fs_id(numlink),Fc_id(numlink))
        elseif numlink==2
            [vs_id(numlink)]=step3(qp_step3(:,numlink),qpp_step3(:,numlink),u_step3.signals.values(:,numlink),k3_id,Fs_id(numlink),Fc_id(numlink))
        end
        
        %[vs_id(numlink)]=step3(qp_step3(:,numlink),qpp_step3(:,numlink),u_step3.signals.values(:,numlink),J_id(numlink),Fs_id(numlink),Fc_id(numlink))
        s=sprintf('Datos identificados para la articulación %d\n\nvs(%d) = %f\n',numlink,numlink,vs_id(numlink));
        disp(s);
        disp('Ahora puede ejecutar los ensayos de STEP 4');
    case 4
        disp('- STEP 4 -------------------------------------------------------');
        disp('(Identificación de sigma0 y sigma1)');
        name=strcat('DATA_Ident_friccion_STEP4_link',nlink,'_v',nens,'.mat');
        load(name);
        plot(q_step4(:,numlink),u_se_step4.signals.values(:,numlink));
        title('Mapa de deformación en la región de predeslizamiento');
        xlabel('Desplazamiento (rad)');
        ylabel('Par (Nm)');
        
        if numlink==1
            [sigma0_id(numlink),sigma1_id(numlink)]=step4(q_step4(:,numlink),u_se_step4.signals.values(:,numlink),ka_id(numlink),sigma2_id(numlink));
        elseif numlink==2
            [sigma0_id(numlink),sigma1_id(numlink)]=step4(q_step4(:,numlink),u_se_step4.signals.values(:,numlink),k3_id(numlink),sigma2_id(numlink));
        end
        
        %[sigma0_id(numlink),sigma1_id(numlink)]=step4(q_step4(:,numlink),u_se_step4.signals.values(:,numlink),J_id(numlink),sigma2_id(numlink));
        s=sprintf('Datos identificados para la articulación %d\n\nsigma0(%d) = %f\nsigma1(%d) = %f\n',numlink,numlink,sigma0_id(numlink),numlink,sigma1_id(numlink));
        disp(s);
        disp('FIN de la etapa de identificación del modelo LUGRE');
        disp('Datos guardados en');
        name=strcat('DATA_Ident_friccion_link',nlink,'_v',nens,'.mat');
        disp(name);
        save (name,'ka_id','kb_id','kc_id','k3_id','k5_id','Fc_id','Fsmas_id','Fsmenos_id','Fs_id','sigma0_id','sigma1_id','sigma2_id');
    otherwise
        disp('No ha seleccionado una etapa de identificación válida');
end

%representacion_pares
