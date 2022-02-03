
clear all
close all
clc

% CORRECCIÓN DE LA EXCENTRICIDAD:

load('Valores_identificados_step1.mat');

numlink = 2;

if numlink == 1
    load('DATA_Ident_friccion_STEP2_link1_v5.mat');
    u_step2m = mean(u_step2(:,numlink));
    s1m = mean(sin(q_step2(:,numlink)));

    kb_correg5 = u_step2m/s1m;

    load('DATA_Ident_friccion_STEP2_link1_v6.mat');
    u_step2m = mean(u_step2(:,numlink));
    s1m = mean(sin(q_step2(:,numlink)));

    kb_correg6 = u_step2m/s1m;

    load('DATA_Ident_friccion_STEP2_link1_v7.mat');
    u_step2m = mean(u_step2(:,numlink));
    s1m = mean(sin(q_step2(:,numlink)));

    kb_correg7 = u_step2m/s1m;

    load('DATA_Ident_friccion_STEP2_link1_v8.mat');
    u_step2m = mean(u_step2(:,numlink));
    s1m = mean(sin(q_step2(:,numlink)));

    kb_correg8 = u_step2m/s1m;
    kb_correg = (kb_correg5+kb_correg6+kb_correg7+kb_correg6)/4
end



if numlink == 2
    load('DATA_Ident_friccion_STEP2_link2_v1.mat');
    u_step2m = mean(u_step2(:,numlink));
    s2m = mean(sin(q_step2(:,numlink)));

    k5_correg1 = u_step2m/s2m;

    load('DATA_Ident_friccion_STEP2_link2_v2.mat');
    u_step2m = mean(u_step2(:,numlink));
    s2m = mean(sin(q_step2(:,numlink)));

    k5_correg2 = u_step2m/s2m;

    load('DATA_Ident_friccion_STEP2_link2_v3.mat');
    u_step2m = mean(u_step2(:,numlink));
    s2m = mean(sin(q_step2(:,numlink)));

    k5_correg3 = u_step2m/s2m;

    load('DATA_Ident_friccion_STEP2_link2_v4.mat');
    u_step2m = mean(u_step2(:,numlink));
    s2m = mean(sin(q_step2(:,numlink)));

    k5_correg4 = u_step2m/s2m;
    k5_correg = (k5_correg1+k5_correg2+k5_correg3+k5_correg4)/4
end
  


if numlink == 1
    
    load('DATA_Ident_friccion_STEP2_link1_v5.mat');
    
    % Cálculo de u_se_step2 a partir de u_step2 y de q_step2:

    delta = 0.001;                   % Tiempo de muestreo de xPC Target 
    tau_Fs = 0.001;  % Constante de tiempo del filtro paso-bajo del regresor
    filtro_cont=tf([1],[tau_Fs 1]); % Filtro paso bajo continuo para el regresor
    filtro_disc=c2d(filtro_cont,delta,'tustin');  % Filtro paso bajo discreto para la velocidad

    u_se_step2 = zeros(size(q_step2,1),2);

    u_se_step2(:,numlink)= u_step2(:,numlink)- kb_correg*sin(q_step2(:,numlink));
   
    u_se_step2(:,numlink) = lsim(filtro_disc,u_se_step2(:,numlink));
    

    % Representación del ciclo límite de Hunting:

    figure(5);
    plot(t,q_step2(:,numlink),'g-',t,u_step2(:,numlink),'b-',t,u_se_step2(:,numlink),'r-');
    grid on;
    xlabel('Tiempo (s)');
    legend('Posición (rad)','Señal de control real','Señal de control parcial y filtrada');
    title('Ciclo límite de Hunting');
    
    save('DATA_Ident_friccion_STEP2_link1_v5.mat');
    

    load('DATA_Ident_friccion_STEP2_link1_v6.mat');
    
    % Cálculo de u_se_step2 a partir de u_step2 y de q_step2:

    delta = 0.001;                   % Tiempo de muestreo de xPC Target 
    tau_Fs = 0.001;  % Constante de tiempo del filtro paso-bajo del regresor
    filtro_cont=tf([1],[tau_Fs 1]); % Filtro paso bajo continuo para el regresor
    filtro_disc=c2d(filtro_cont,delta,'tustin');  % Filtro paso bajo discreto para la velocidad

    u_se_step2 = zeros(size(q_step2,1),2);

    u_se_step2(:,numlink)= u_step2(:,numlink)- kb_correg*sin(q_step2(:,numlink));
   
    u_se_step2(:,numlink) = lsim(filtro_disc,u_se_step2(:,numlink));
    

    % Representación del ciclo límite de Hunting:

    figure(5);
    plot(t,q_step2(:,numlink),'g-',t,u_step2(:,numlink),'b-',t,u_se_step2(:,numlink),'r-');
    grid on;
    xlabel('Tiempo (s)');
    legend('Posición (rad)','Señal de control real','Señal de control parcial y filtrada');
    title('Ciclo límite de Hunting');
    
    save('DATA_Ident_friccion_STEP2_link1_v6.mat');  
    
    
    load('DATA_Ident_friccion_STEP2_link1_v7.mat');
    
    % Cálculo de u_se_step2 a partir de u_step2 y de q_step2:

    delta = 0.001;                   % Tiempo de muestreo de xPC Target 
    tau_Fs = 0.001;  % Constante de tiempo del filtro paso-bajo del regresor
    filtro_cont=tf([1],[tau_Fs 1]); % Filtro paso bajo continuo para el regresor
    filtro_disc=c2d(filtro_cont,delta,'tustin');  % Filtro paso bajo discreto para la velocidad

    u_se_step2 = zeros(size(q_step2,1),2);

    u_se_step2(:,numlink)= u_step2(:,numlink)- kb_correg*sin(q_step2(:,numlink));
   
    u_se_step2(:,numlink) = lsim(filtro_disc,u_se_step2(:,numlink));
    

    % Representación del ciclo límite de Hunting:

    figure(5);
    plot(t,q_step2(:,numlink),'g-',t,u_step2(:,numlink),'b-',t,u_se_step2(:,numlink),'r-');
    grid on;
    xlabel('Tiempo (s)');
    legend('Posición (rad)','Señal de control real','Señal de control parcial y filtrada');
    title('Ciclo límite de Hunting');
    
    save('DATA_Ident_friccion_STEP2_link1_v7.mat');
    
    
    load('DATA_Ident_friccion_STEP2_link1_v8.mat');
    
    % Cálculo de u_se_step2 a partir de u_step2 y de q_step2:

    delta = 0.001;                   % Tiempo de muestreo de xPC Target 
    tau_Fs = 0.001;  % Constante de tiempo del filtro paso-bajo del regresor
    filtro_cont=tf([1],[tau_Fs 1]); % Filtro paso bajo continuo para el regresor
    filtro_disc=c2d(filtro_cont,delta,'tustin');  % Filtro paso bajo discreto para la velocidad

    u_se_step2 = zeros(size(q_step2,1),2);

    u_se_step2(:,numlink)= u_step2(:,numlink)- kb_correg*sin(q_step2(:,numlink));
   
    u_se_step2(:,numlink) = lsim(filtro_disc,u_se_step2(:,numlink));
    

    % Representación del ciclo límite de Hunting:

    figure(5);
    plot(t,q_step2(:,numlink),'g-',t,u_step2(:,numlink),'b-',t,u_se_step2(:,numlink),'r-');
    grid on;
    xlabel('Tiempo (s)');
    legend('Posición (rad)','Señal de control real','Señal de control parcial y filtrada');
    title('Ciclo límite de Hunting');
    
    save('DATA_Ident_friccion_STEP2_link1_v8.mat');
    
end


if numlink == 2
    
    load('DATA_Ident_friccion_STEP2_link2_v1.mat');
    
    % Cálculo de u_se_step2 a partir de u_step2 y de q_step2:

    delta = 0.001;                   % Tiempo de muestreo de xPC Target 
    tau_Fs = 0.001;  % Constante de tiempo del filtro paso-bajo del regresor
    filtro_cont=tf([1],[tau_Fs 1]); % Filtro paso bajo continuo para el regresor
    filtro_disc=c2d(filtro_cont,delta,'tustin');  % Filtro paso bajo discreto para la velocidad

    u_se_step2 = zeros(size(q_step2,1),2);

    u_se_step2(:,numlink)= u_step2(:,numlink)- k5_correg*sin(q_step2(:,numlink));
   
    u_se_step2(:,numlink) = lsim(filtro_disc,u_se_step2(:,numlink));
    

    % Representación del ciclo límite de Hunting:

    figure(5);
    plot(t,q_step2(:,numlink),'g-',t,u_step2(:,numlink),'b-',t,u_se_step2(:,numlink),'r-');
    grid on;
    xlabel('Tiempo (s)');
    legend('Posición (rad)','Señal de control real','Señal de control parcial y filtrada');
    title('Ciclo límite de Hunting');
    
    save('DATA_Ident_friccion_STEP2_link2_v1.mat');
    

    load('DATA_Ident_friccion_STEP2_link2_v2.mat');
    
    % Cálculo de u_se_step2 a partir de u_step2 y de q_step2:

    delta = 0.001;                   % Tiempo de muestreo de xPC Target 
    tau_Fs = 0.001;  % Constante de tiempo del filtro paso-bajo del regresor
    filtro_cont=tf([1],[tau_Fs 1]); % Filtro paso bajo continuo para el regresor
    filtro_disc=c2d(filtro_cont,delta,'tustin');  % Filtro paso bajo discreto para la velocidad

    u_se_step2 = zeros(size(q_step2,1),2);

    u_se_step2(:,numlink)= u_step2(:,numlink)- k5_correg*sin(q_step2(:,numlink));
   
    u_se_step2(:,numlink) = lsim(filtro_disc,u_se_step2(:,numlink));
    

    % Representación del ciclo límite de Hunting:

    figure(5);
    plot(t,q_step2(:,numlink),'g-',t,u_step2(:,numlink),'b-',t,u_se_step2(:,numlink),'r-');
    grid on;
    xlabel('Tiempo (s)');
    legend('Posición (rad)','Señal de control real','Señal de control parcial y filtrada');
    title('Ciclo límite de Hunting');
    
    save('DATA_Ident_friccion_STEP2_link2_v2.mat');  
    
    
    load('DATA_Ident_friccion_STEP2_link2_v3.mat');
    
    % Cálculo de u_se_step2 a partir de u_step2 y de q_step2:

    delta = 0.001;                   % Tiempo de muestreo de xPC Target 
    tau_Fs = 0.001;  % Constante de tiempo del filtro paso-bajo del regresor
    filtro_cont=tf([1],[tau_Fs 1]); % Filtro paso bajo continuo para el regresor
    filtro_disc=c2d(filtro_cont,delta,'tustin');  % Filtro paso bajo discreto para la velocidad

    u_se_step2 = zeros(size(q_step2,1),2);

    u_se_step2(:,numlink)= u_step2(:,numlink)- k5_correg*sin(q_step2(:,numlink));
   
    u_se_step2(:,numlink) = lsim(filtro_disc,u_se_step2(:,numlink));
    

    % Representación del ciclo límite de Hunting:

    figure(5);
    plot(t,q_step2(:,numlink),'g-',t,u_step2(:,numlink),'b-',t,u_se_step2(:,numlink),'r-');
    grid on;
    xlabel('Tiempo (s)');
    legend('Posición (rad)','Señal de control real','Señal de control parcial y filtrada');
    title('Ciclo límite de Hunting');
    
    save('DATA_Ident_friccion_STEP2_link2_v3.mat');
    
    
    load('DATA_Ident_friccion_STEP2_link2_v4.mat');
    
    % Cálculo de u_se_step2 a partir de u_step2 y de q_step2:

    delta = 0.001;                   % Tiempo de muestreo de xPC Target 
    tau_Fs = 0.001;  % Constante de tiempo del filtro paso-bajo del regresor
    filtro_cont=tf([1],[tau_Fs 1]); % Filtro paso bajo continuo para el regresor
    filtro_disc=c2d(filtro_cont,delta,'tustin');  % Filtro paso bajo discreto para la velocidad

    u_se_step2 = zeros(size(q_step2,1),2);

    u_se_step2(:,numlink)= u_step2(:,numlink)- k5_correg*sin(q_step2(:,numlink));
   
    u_se_step2(:,numlink) = lsim(filtro_disc,u_se_step2(:,numlink));
    

    % Representación del ciclo límite de Hunting:

    figure(5);
    plot(t,q_step2(:,numlink),'g-',t,u_step2(:,numlink),'b-',t,u_se_step2(:,numlink),'r-');
    grid on;
    xlabel('Tiempo (s)');
    legend('Posición (rad)','Señal de control real','Señal de control parcial y filtrada');
    title('Ciclo límite de Hunting');
    
    save('DATA_Ident_friccion_STEP2_link2_v4.mat');
    
end


    
