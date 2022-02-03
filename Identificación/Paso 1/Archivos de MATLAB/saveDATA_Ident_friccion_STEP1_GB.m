
% Guarda en un fichero .mat los datos DE POSICIÓN (entre otras cosas) correspondientes a la fase STEP1 de
% identificación del modelo de LUGRE
% Este código se ejecuta automaticamente como parte de una 'callback
% function' del modelo 'Ident_friccion_step1_GB2.mdl'

clc
    nlink = input('Introduzca el número de la articulación sobre la que ha efectuado el ensayo\nde identificación (1=Hombro, 2=Codo)','s');
    nens = input('\nIntroduzca el número de Ensayo realizado ','s');
    if str2num(nlink)<1 ||  str2num(nlink)>2
       disp('No se han guardado los datos. Debe especificar un valor de articulacion válido');
       return
    end
    name=strcat('Posicion_Ident_friccion_STEP1_link',nlink,'_v',nens,'.mat');
    
    t=tg.TimeLog;

    q_step1_1=tg.Outputlog(:,1);
    q_step1_2=tg.Outputlog(:,2);
    qp_step1_1=tg.Outputlog(:,3);
    qp_step1_2=tg.Outputlog(:,4);
    Phi1_mdl_1=tg.Outputlog(:,5);
    Phi1_mdl_2=tg.Outputlog(:,6);
    Phi1_mdl_3=tg.Outputlog(:,7);
    Phi1_mdl_4=tg.Outputlog(:,8);
    Phi1_mdl_5=tg.Outputlog(:,9);
    Phi2_mdl_1=tg.Outputlog(:,10);
    Phi2_mdl_2=tg.Outputlog(:,11);
    Phi2_mdl_3=tg.Outputlog(:,12);
    Phi2_mdl_4=tg.Outputlog(:,13);
    y1_mdl=tg.Outputlog(:,14);
    y2_mdl=tg.Outputlog(:,15);
    u_step1_1=tg.Outputlog(:,16);
    u_step1_2=tg.Outputlog(:,17);
    pares_step1_1=tg.Outputlog(:,18);
    pares_step1_2=tg.Outputlog(:,19);
    offset_h=tg.Outputlog(:,20);
    offset_c=tg.Outputlog(:,21);
    
    
    pares_step1 = [pares_step1_1 pares_step1_2];
    
    u_step1 = [u_step1_1 u_step1_2];
    
    q_step1 = [q_step1_1 q_step1_2];
    
    qp_step1 = [qp_step1_1 qp_step1_2];
    
    Phi1_mdl = [Phi1_mdl_1 Phi1_mdl_2 Phi1_mdl_3 Phi1_mdl_4 Phi1_mdl_5];
    
    Phi2_mdl = [Phi2_mdl_1 Phi2_mdl_2 Phi2_mdl_3 Phi2_mdl_4];
    
    
    if str2num(nlink)==1
       save (name,'t','y1_mdl','q_step1','u_step1','pares_step1','offset_h');
    elseif str2num(nlink)==2
       save (name,'t','y2_mdl','q_step1','u_step1','pares_step1','offset_c');
    end
    disp(' ');
    disp('Datos de identificación guardados en');
    disp(name);

    
    % SE GUARDAN DATOS DE POSICIÓN, ENTRADAS Y OFFSET, NO EL REGRESOR




