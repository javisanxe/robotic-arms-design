% Guarda en un fichero .mat los datos correspondientes a la fase STEP3 de
% identificación del modelo de LUGRE
% Este código se ejecuta automáticamente como parte de una 'callback
% function' del modelo 'ident_friccion_STEP3_GB2.mdl'

clc

    nlink = input('Introduzca el número de la articulación sobre la que ha efectuado el ensayo\nde identificación (1=Hombro, 2=Codo)','s');
    nens = input('\nIntroduzca el número de ensayo realizado ','s');
    if str2num(nlink)<1 ||  str2num(nlink)>2
       disp('No se han guardado los datos. Debe especificar un valor de articulación válido');
       return
    end
    name=strcat('Posicion_Ident_friccion_STEP3_link',nlink,'_v',nens,'.mat');
    
    t=tg.TimeLog;
    
    u_step3_1 = tg.Outputlog(:,1);
    u_step3_2 = tg.Outputlog(:,2);
    u_step3 = [u_step3_1 u_step3_2];
    
    q_step3_1 = tg.Outputlog(:,3);
    q_step3_2 = tg.Outputlog(:,4);
    q_step3 = [q_step3_1 q_step3_2];
    
    qp_step3_1 = tg.Outputlog(:,5);
    qp_step3_2 = tg.Outputlog(:,6);
    qp_step3 = [qp_step3_1 qp_step3_2];
    
    offset_h = tg.Outputlog(:,7);
    offset_c = tg.Outputlog(:,8);
    
    if str2num(nlink)==1
        
        save (name,'t','q_step3','u_step3','offset_h');
        
    end
    
    if str2num(nlink)==2
        
        save (name,'t','q_step3','u_step3','offset_c');
        
    end
    
        
    disp(' ');
    disp('Datos de identificación guardados en');
    disp(name);






