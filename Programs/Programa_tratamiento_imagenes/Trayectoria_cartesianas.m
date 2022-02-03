% PASAR DE TRAY EN IMAGEN PIXELES BLANCOS, A TRAY CARTESIANA

% 0 Negro 
% 1 Blanco (Trayectoria)
% XG YG centro trayectoria
L1=0.45;
L2=0.45;

%% Obtenemos la trayectoria en coordenadas cartesianas
%%Reecordar: j-x
 %           i-y

[filas,columnas]=size(borde);

%Extremos=[0 YG 0;XG 0 XG;0 YG]

%%Trayectoria realizable completamente?
rmax=0;


for i=1:1:filas
    for j=1:1:columnas
        
        if(borde(i,j)==1)
            
            rx=j-XG;
            ry=-(i-YG);
            
            r=sqrt(rx^2+ry^2);
            
            if(r>rmax)
                rmax=r;
            end
            
        end
        
    end
end

rmax;
Rmax=0.9*(L1+L2);   %%%%
                

%%Punto inicio trayectoria: f(fili,coli)
i=YG;

for j=1:1:columnas
    
    if(borde(YG,j)==1) 
        coli=j; %guardo la posicion del primero pixel blanco en horizontal   
    end

end


%Recorrer matriz
f1=YG
c1=coli


%           Punto inicial
            rx=c1-XG;
            ry=YG-f1;
            
            r=sqrt(rx^2+ry^2);
            
            R=(r*Rmax)/rmax;
            teta=atan2(ry,rx);
            
            X=R*cos(teta);
            Y=R*sin(teta);

XY=[X Y];



encontrado=1;
 while(encontrado==1)
            
     encontrado=0;
            for i=-1:1:1
                for j=-1:1:1
                    if(borde(f1+i,c1+j)==1 && encontrado==0)
                        borde(f1,c1)=0;
                        encontrado=1;
                       
                        f1=f1+i;
                        c1=c1+j;
                    end
                end
            end
            if(encontrado==0)
            for i=-2:1:2
                for j=-2:1:2
                    if(borde(f1+i,c1+j)==1 && encontrado==0)
                       
                        borde(f1,c1)=0;
                        encontrado=1;
                       
                        f1=f1+i;
                        c1=c1+j;
                    end
                end
            end
            end
            
            rx=c1-XG;
            ry=-(f1-YG);
            
            r=sqrt(rx^2+ry^2);
            
            R=(r*Rmax)/rmax;
            teta=atan2(ry,rx);
            
            X=R*cos(teta);
            Y=R*sin(teta);
            
            XY=[XY;X Y];
                
 end
        
 
 figure
 plot(XY(:,1),XY(:,2),'r')





