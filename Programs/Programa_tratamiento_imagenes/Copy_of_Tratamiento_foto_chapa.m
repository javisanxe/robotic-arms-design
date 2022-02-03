clc
clear
foto=imread('C:\Users\TrendingPC\Desktop\Programas\Imagenes\engranaje2.jpg','jpg'); %Leo la imagen para obtener las matrices R,G y B

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
suma = (double(fr)+ double(fv) +double(fa))/3;  %Formato double [0,255]

f=suma/255;  %Formato double [0,1]
imshow(f); %La muestro en escala de grises

%%%%%%%%%%%%%%%%%%%%%%%%
f=imrotate(f,90);             %!!!!!!!!!!!!!!!!!!!!!!!
%%%%%%%%%%%%%%%%%%%%%%%%
%% Contorno 
%--Se puede hacer manual como en P1A_contorno (teoría), aquí se hace con edge

%--Previo al edge, Podemos usar el método Otsu para separación de las
%regiones en figura-fondo para que no haya ruido o otros elementos.

%--Despues de el filtrado podemos hacer algun filtrado o método morfológico
%eroda-dilatate para dejalo ESKIIIISO


umbral= 0.95*255;  %Chapa

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

se = strel('cube',3);
plantilla_area = imerode(plantilla_area, se);
imshow(plantilla_area)

micentro = regionprops( plantilla_area, 'Centroid')

whos micentro

XG = floor(micentro.Centroid(1));
YG = floor(micentro.Centroid(2));

%Mostramos el centro de la trayectoria
figure
imshow(borde);
hold on
plot( XG, YG, 'rx', 'MarkerSize', 18, 'LineWidth', 3)


close all;
borde(792,76)=0;
borde(793,76)=0;
borde(794,76)=0;
borde(792,77)=0;
borde(792,78)=0;
borde(793,78)=0;

borde(1294,154)=0;
borde(1295,154)=0;
borde(1296,154)=0;
borde(1296,155)=0;
borde(1296,156)=0;



imshow(borde);

% close all;


 

