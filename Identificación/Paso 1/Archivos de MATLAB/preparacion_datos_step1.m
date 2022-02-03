
% ARCHIVO QUE PREPARA LOS DATOS DE POSICIÓN OBTENIDOS EN EL EXPERIMENTO,
% CALCULA NUMÉRICAMENTE LA VELOCIDAD Y ACELERACIÓN, Y CALCULA
% ANALÍTICAMENTE EL REGRESOR NECESARIO PARA EL STEP 1

% DEBE EJECUTARSE CONSCIENTEMENTE A PARTIR DE UN ARCHIVO DE DATOS DE
% NOMBRE: Posicion_Ident_friccion_STEP1_linkX_vY, siendo X el número de la
% articulación (1=hombro,2_codo), y Y el número de experimento. 
% NO SE EJECUTA COMO CALLBACK DEL MODELO, ES UN ALGORITMO QUE DEBE
% EJECUTARSE FUERA DE LÍNEA

% FINALMENTE GUARDA LOS DATOS NECESARIOS PARA APLICAR DIRECTAMENTE EL        
% STEP 1 EN UN ARCHIVO DE NOMBRE: DATA_Ident_friccion_STEP1_linkX_vY, donde
% X e Y tienen el mismo significado y valor que en el archivo anterior.


clear all
close all
clc

disp('IDENTIFICACIÓN DE FRICCIÓN DE LUGRE, STEP 1');

nlink = input('\nIntroduzca el número de la articulación a identificar\n(1=Hombro, 2=Codo)? ','s');
nens = input('\n Número de la sesión de datos para importar? ','s');
numlink=str2num(nlink);
numens=str2num(nens);
disp(' ')
name=strcat('Posicion_Ident_friccion_STEP1_link',nlink,'_v',nens,'.mat');
load(name);


disp('FASE I:')
disp(' ')
disp('DETECCIÓN DE OFFSET (FUNCIÓN DE HOMING)')

switch str2num(nlink)
    case 1
        instante_hombro = primer_valor_no_nulo(offset_h);
        disp('El offset del hombro es')
        disp(offset_h(instante_hombro))
        if instante_hombro == 1
            instante_hombro = 1500;
        end
        
        n_h = length(offset_h)-instante_hombro+1;
        q_step1_aux(1:n_h,:) = q_step1(instante_hombro:end,:);
        clear q_step1
        q_step1 = q_step1_aux;
        t_aux(1:n_h,:) = t(instante_hombro:end,:);
        clear t
        t = t_aux;
    case 2
        instante_codo = primer_valor_no_nulo(offset_c);
        disp('El offset del codo es')
        disp(offset_c(instante_codo))
        n_c = length(offset_c)-instante_codo+1;
        q_step1_aux(1:n_c,:) = q_step1(instante_codo:end,:);
        clear q_step1
        q_step1 = q_step1_aux;
    otherwise
        disp('No ha seleccionado una articulación válida');
end





disp('FASE II:')
disp(' ')
disp('DERIVACIÓN NUMÉRICA DE LA POSICIÓN, OBTENCIÓN DE VELOCIDAD Y ACELERACIÓN')


% Aplicación del algoritmo mínimo-cuadrático a la posición:
qp_ls = minimos_cuadrados_var(q_step1,t,numlink,7);       % Algoritmo mínimo cuadrático para el cálculo de la velocidad a partir de la posición suavizada 

% Filtro paso bajo para la velocidad anterior:

delta=0.001;                   % Tiempo de muestreo de xPC Target 

tauv=0.01;                     % Constante de tiempo del filtro para la velocidad
taua=0.05;                     % Constante de tiempo del filtro para la aceleración

fvv=tf([1],[tauv 1]);          % Filtro paso bajo continuo para la velocidad
fva=tf([1],[taua 1]);          % Filtro paso bajo continuo para la aceleración

fvdv=c2d(fvv,delta,'tustin');  % Filtro paso bajo discreto para la velocidad
fvda=c2d(fva,delta,'tustin');  % Filtro paso bajo discreto para la aceleración


qp_ls_h_fil=lsim(fvdv,qp_ls(:,1));        % Velocidad numérica del hombro filtrada 
qp_ls_c_fil=lsim(fvdv,qp_ls(:,2));        % Velocidad numérica del codo filtrada 

qp_ls_fil = [qp_ls_h_fil qp_ls_c_fil];           % Velocidad obtenida numéricamente con algoritmo de mínimos cuadrados a partir de la posición, y filtrada con filtro paso-bajo


% Aplicación del algoritmo mínimo-cuadrático a la velocidad anterior:
qpp_ls = minimos_cuadrados_var(qp_ls_fil,t,numlink,7);     % Algoritmo mínimo cuadrático para el cálculo de la aceleración a partir de la velocidad suavizada

% Filtro paso bajo para la aceleración anterior:

qpp_ls_h_fil=lsim(fvda,qpp_ls(:,1));      % Aceleración numérica del hombro filtrada
qpp_ls_c_fil=lsim(fvda,qpp_ls(:,2));      % Aceleración numérica del codo filtrada

qpp_ls_fil = [qpp_ls_h_fil qpp_ls_c_fil];  % Aceleración obtenida numéricamente con algoritmo de mínimos cuadrados a partir de la velocidad numérica y filtrada con filtro paso-bajo



%*************************************************************************
% Filtro de 5º orden
qp_nd5p = zeros(size(q_step1,1),2);
qpp_nd5p = zeros(size(q_step1,1),2);

qp_nd5p(:,numlink) = (nd5p(q_step1(:,numlink),delta,length(q_step1(:,numlink))))';  % Traspuesto ya que nd5p devuelve un vector fila
qpp_nd5p(:,numlink) = (nd5p(qp_nd5p(:,numlink),delta,length(qp_nd5p(:,numlink))))'; % Traspuesto ya que nd5p devuelve un vector fila

%*******Velocidad SG******************************************************************

nR=50;
nL=50;
c=sgfilter(nL,nR,5,1);
l=size(q_step1,1);
qp_sg=zeros(l,2);

for i=nL+1:l-nR
    s=0;
    for j=-nL:nR
        s=s+c(j+nL+1)*q_step1(i+j,numlink);
    end
    qp_sg(i,numlink)=s/delta;
end

%********Aceleracion SG*****************************************************************
nR=50;
nL=50;
c=sgfilter(nL,nR,2,2);
l=size(q_step1,1);
qpp_sg=zeros(l,2);

for i=nL+1:l-nR
    s=0;
    for j=-nL:nR
        s=s+c(j+nL+1)*q_step1(i+j,numlink);
    end
    %qpp_sg(i,numlink)=s/(delta*delta);
    qpp_sg(i,numlink)=2*s/(delta*delta);
end


% Representación de los resultados:

switch numlink
    
    case 1
        
        figure(1);
        plot(t,q_step1(:,1),'b-',t,qp_ls_fil(:,1),'r-',t,qpp_ls_fil(:,1),'m-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Posición (rad)','Velocidad numérica (mínimos cuadrados, filtrada) (rad/s)','Aceleración numérica (mínimos cuadrados, filtrada) (rad/s2)');
        title('HOMBRO'); 
        
        figure(2);
        plot(t,q_step1(:,1),'b-',t,qp_nd5p(:,1),'r-',t,qpp_nd5p(:,1),'m-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Posición (rad)','Velocidad numérica (nd5p) (rad/s)','Aceleración numérica (nd5p) (rad/s2)');
        title('HOMBRO'); 
        
        figure(3);
        plot(t,q_step1(:,1),'b-',t,qp_sg(:,1),'r-',t,qpp_sg(:,1),'m-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Posición (rad)','Velocidad numérica (sg) (rad/s)','Aceleración numérica (sg) (rad/s2)');
        title('HOMBRO');         

    case 2
        
        figure(1);
        plot(t,q_step1(:,2),'b-',t,qp_ls_fil(:,2),'r-',t,qpp_ls_fil(:,2),'m-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Posición (rad)','Velocidad numérica (mínimos cuadrados, filtrada) (rad/s)','Aceleración numérica (mínimos cuadrados, filtrada) (rad/s2)');
        title('CODO');
        
        figure(2);
        plot(t,q_step1(:,2),'b-',t,qp_nd5p(:,2),'r-',t,qpp_nd5p(:,2),'m-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Posición (rad)','Velocidad numérica (nd5p) (rad/s)','Aceleración numérica (nd5p) (rad/s2)');
        title('CODO'); 
        
        figure(3);
        plot(t,q_step1(:,2),'b-',t,qp_sg(:,2),'r-',t,qpp_sg(:,2),'m-');
        grid on;
        xlabel('Tiempo (s)');
        legend('Posición (rad)','Velocidad numérica (sg) (rad/s)','Aceleración numérica (sg) (rad/s2)');
        title('CODO');         
                
    otherwise
        
        disp('No ha seleccionado una articulación válida');
        
end

% Elección definitiva del método de derivación:

qp_step1 = qp_sg;
qpp_step1 = qpp_sg;



disp('FASE III:')
disp(' ')
disp('CÁLCULO ANALÍTICO DEL REGRESOR CORRESPONDIENTE A LA ARTICULACIÓN SELECCIONADA, PARA EL STEP 1')

delta = 0.001;                   % Tiempo de muestreo de xPC Target 
tau = 0.001;  % Constante de tiempo del filtro paso-bajo del regresor
filtro_cont=tf([1],[tau 1]); % Filtro paso bajo continuo para el regresor
filtro_disc=c2d(filtro_cont,delta,'tustin');  % Filtro paso bajo discreto para la velocidad

switch str2num(nlink)
    
    case 1
        Phi1_mdl = zeros(size(q_step1,1),5);
        Phi1_mdl(:,1) = lsim(filtro_disc,qpp_step1(:,1));
        s1(:,1) = sin(q_step1(:,1));
        Phi1_mdl(:,2) = lsim(filtro_disc,s1(:,1));
        c1(:,1) = cos(q_step1(:,1));
        Phi1_mdl(:,3) = lsim(filtro_disc,c1(:,1));
        signo(:,1) = sign(qp_step1(:,1));
        Phi1_mdl(:,4) = lsim(filtro_disc,signo(:,1));
        Phi1_mdl(:,5) = lsim(filtro_disc,qp_step1(:,1));
                
    case 2
        Phi2_mdl = zeros(size(q_step1,1),4);
        Phi2_mdl(:,1) = lsim(filtro_disc,qpp_step1(:,2));
        s12(:,1) = sin(q_step1(:,1)+q_step1(:,2));
        Phi2_mdl(:,2) = lsim(filtro_disc,s12(:,1));
        signo(:,1) = sign(qp_step1(:,2));
        Phi2_mdl(:,3) = lsim(filtro_disc,signo(:,1));
        Phi2_mdl(:,4) = lsim(filtro_disc,qp_step1(:,2));
           
    otherwise
        disp('No ha seleccionado una articulación válida');
end




disp('FASE IV:')
disp(' ')
disp('ALMACENAMIENTO DE DATOS NECESARIOS PARA EL STEP 1')

name2=strcat('DATA_Ident_friccion_STEP1_link',nlink,'_v',nens,'.mat');

if str2num(nlink)==1
       save (name2,'t','y1_mdl','q_step1','u_step1','pares_step1','offset_h','qp_step1','qpp_step1','Phi1_mdl');
elseif str2num(nlink)==2
       save (name2,'t','y2_mdl','q_step1','u_step1','pares_step1','offset_c','qp_step1','qpp_step1','Phi2_mdl');
end

disp(' ');
disp('Datos de identificación necesarios para el step 1 guardados en');
disp(name2);





