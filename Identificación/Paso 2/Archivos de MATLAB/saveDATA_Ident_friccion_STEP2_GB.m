% Guarda en un fichero .mat los datos correspondientes a la fase STEP2 de
% identificación del modelo de LUGRE
% Este código se ejecuta automaticamente como parte de una 'callback
% function' del modelo 'ident_friccion_STEP2.mdl'

clc

    nlink = input('Introduzca el número de la articulación sobre la que ha efectuado el ensayo\nde identificación (1=Hombro, 2=Codo)','s');
    nens = input('\nIntroduzca el número de ensayo realizado ','s');
    if str2num(nlink)<1 ||  str2num(nlink)>2
       disp('No se han guardado los datos. Debe especificar un valor de articulacion válido');
       return
    end
    name=strcat('Posicion_Ident_friccion_STEP2_link',nlink,'_v',nens,'.mat');
    
    t=tg.TimeLog;
    
    u_step2_1=tg.Outputlog(:,1);
    u_step2_2=tg.Outputlog(:,2);
    u_step2 = [u_step2_1 u_step2_2];
    
    u_se_step2_1=tg.Outputlog(:,3);
    u_se_step2_2=tg.Outputlog(:,4);
    u_se_step2 = [u_se_step2_1 u_se_step2_2];
    
    q_step2_1=tg.Outputlog(:,5);
    q_step2_2=tg.Outputlog(:,6);
    q_step2 = [q_step2_1 q_step2_2];
    
    qp_step2_1=tg.Outputlog(:,7);
    qp_step2_2=tg.Outputlog(:,8);
    qp_step2 = [qp_step2_1 qp_step2_2];
    
    offset_h = tg.Outputlog(:,9);
    offset_c = tg.Outputlog(:,10);
    
    if str2num(nlink)==1
        
        save (name,'t','q_step2','u_step2','u_se_step2','offset_h');
        
    end
    
    if str2num(nlink)==2
        
        save (name,'t','q_step2','u_step2','u_se_step2','offset_c');
        
    end
    disp(' ');
    disp('Datos de identificación guardados en');
    disp(name);






