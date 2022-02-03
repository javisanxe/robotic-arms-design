% Función que calcula una regresión cuadrática recursiva con factor de
% olvido lambda(Exponentialy weighted recursive least squares o EWRLS)
% Es decir, calcula el valor de theta que minimiza el indice de
% comportamiento J_k(theta)

% J_k(theta)=1/2*Sum{i=1}{i=k} lambda^(k-i)[y(i)-Phi(i)^T*theta]^T *
% [y(i)-Phi(i)^T*theta]

% para el regresor y(k)=Phi(k)^T * theta(k)

% donde y(k) y theta(k) son vectores columna y Phi(k) una matriz de
% dimensiones compatibles

% Parámetros:
% y ---> Vector de celdas (cell array) que los valores del vector y(i)
% Phi --> Vector de celdas (cell array) que los valores de la matriz Phi(i)
% theta0 ---> valor incial de theta
% Lambda -> Factor de olvido. Debe ser tal que 0<lambda<=1

% Devuelve
% theta ---> valor optimo estimado
% error ---> Matriz que contiene por columnas es error calculado en cada
% iteración

function [theta,error]=ewrls(Phi,y,theta0,lambda)
n=size(Phi,2);
n2=size(y,2);
if (n~=n2)
    disp('Error: Longitudes de Phi e y diferentes');
    return
end
dy=size(y{1},1);
dtheta=size(theta0,1);

theta_ant=theta0;
P_ant=1000*eye(dtheta);
em=[];
for i=1:n
    mat_inv= Phi{i}'*P_ant*Phi{i}+lambda*eye(dy);
    %det(mat_inv)
    if abs(det(mat_inv))<1e-6
        continue
    end
    P=P_ant/lambda-(1/lambda)*P_ant*Phi{i}*inv(mat_inv)*Phi{i}'*P_ant;
    e=y{i}-Phi{i}'*theta_ant;
    theta=theta_ant+P_ant*Phi{i}*inv(mat_inv)*e;
    em=[em e];
    theta_ant=theta;
    P_ant=P;
end
error=em;

