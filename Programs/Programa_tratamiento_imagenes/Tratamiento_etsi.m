close all
clc
clear
foto=imread('C:\Users\TrendingPC\Desktop\Programas\Imagenes\logoetsi2.jpg','jpg'); %Leo la imagen para obtener las matrices R,G y B

%Separamos las matrices
fr = foto( :,:,1);
fv = foto( :,:,2);
fa = foto( :,:,3);

% figure
% subplot(3,1,1)
% imshow( fr)
% title('CANAL ROJO')
% subplot(3,1,2)
% imshow( fv)
% title('CANAL VERDE')
% subplot(3,1,3)
% imshow( fa)
% title('CANAL AZUL')

%Formar una imagen en tonos de gris: Media de las 3 matrices
maximo1 = min(double(fr),double(fv));
maximo  = min(maximo1,double(fa));%Formato double [0,255]

f=maximo/255;  %Formato double [0,1]
imshow(f); %La muestro en escala de grises

%%%%%%%%%%%%%%%%%%%%%%%%
%f=imrotate(f,90);             %!!!!!!!!!!!!!!!!!!!!!!!
%%%%%%%%%%%%%%%%%%%%%%%%

umbral= 30;     %Apple          %(0-255)
%umbral= 0.5*255;  %Mcdonald
%umbral= 0.8*255;  %Chapa

%*Umbral se puede con Otsu. > o < según figura mas clara o mas oscura que
%fondo
plantilla_area = ( (f*255) < umbral);    %Queremos que la figura sea blancos
% plantilla_area = ( (f*255) > umbral); 
figure
imshow([f, plantilla_area])


figure
borde=edge(plantilla_area,'prewitt');%Hallo los bordes de la pieza %LOGICAL
imshow(borde);
title('Imagen tras edge')
original=borde; %hago una copia para trabajar con filo

%imhist(filo); %Muestro el histograma del borde hallado, deberia de ser todo unos y ceros


%%Centro plantilla  %%SE PUEDE HACER MANUALMENTE TB


micentro = regionprops( plantilla_area, 'Centroid')

whos micentro

XG = floor((465+465+466)/3);
YG = floor((176+511+815)/3);

%Mostramos el centro de la trayectoria
figure
imshow(borde);
hold on
plot( XG, YG, 'rx', 'MarkerSize', 18, 'LineWidth', 3)


close all

