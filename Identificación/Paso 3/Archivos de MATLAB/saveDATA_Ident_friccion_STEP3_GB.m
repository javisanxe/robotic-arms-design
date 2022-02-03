% Guarda en un fichero .mat los datos correspondientes a la fase STEP3 de
% identificaci�n del modelo de LUGRE
% Este c�digo se ejecuta autom�ticamente como parte de una 'callback
% function' del modelo 'ident_friccion_STEP3_GB2.mdl'

clc

    nlink = input('Introduzca el n�mero de la articulaci�n sobre la que ha efectuado el ensayo\nde identificaci�n (1=Hombro, 2=Codo)','s');
    nens = input('\nIntroduzca el n�mero de ensayo realizado ','s');
    if str2num(nlink)<1 ||  str2num(nlink)>2
       disp('No se han guardado los datos. Debe especificar un valor de articulaci�n v�lido');
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
    disp('Datos de identificaci�n guardados en');
    disp(name);






