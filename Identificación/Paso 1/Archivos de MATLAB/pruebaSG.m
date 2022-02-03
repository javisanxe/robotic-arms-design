% Prueba del algoritmo SG

delta=0.05;
t=0:delta:10;
k=4;
q=sin(k*t);
qp=k*cos(k*t);
qpp=-k*k*sin(k*t);

%*******Velocidad SG******************************************************************
nR=10;
nL=10;
c=sgfilter(nL,nR,5,1);
l=size(q,2);
qp_sg=zeros(l,1);
for i=nL+1:l-nR
    s=0;
    for j=-nL:nR
        s=s+c(j+nL+1)*q(i+j);
    end
    qp_sg(i,1)=s/delta;
end
%******** Aceleracion SG *****************************************************************
nR=2;
nL=2;
c=sgfilter(nL,nR,2,2);
l=size(q,2);
qpp_sg=zeros(l,1);
for i=nL+1:l-nR
    s=0;
    for j=-nL:nR
        s=s+c(j+nL+1)*q(i+j);
    end
    %qpp_sg(i,1)=2*s/(delta*delta);
    qpp_sg(i,1)=s/(delta*delta);
end
%******** Graficas SG %*****************************************************************

figure (1);
plot(t,q,'k-',t,qp_sg,'r-',t,qp,'m-',t,qpp_sg,'g-',t,qpp,'b');
grid on;
xlabel('Tiempo (s)');
legend('Posición (rad)','Velocidad SG','Velocidad exacta','Aceleracion SG','Aceleracion exacta');
figure (2);
plot(t,q,'k-',t,qp_sg,'r-',t,qpp_sg);
legend('Posición (rad)','Velocidad SG','Aceleracion SG');
figure (3);
plot(t,qp_sg,'r-',t,qp,'b');
legend('Velocidad SG','Velocidad exacta');
figure (4);
plot(t,qpp_sg,'r-',t,qpp,'b');
legend('Aceleracion SG','Aceleracion exacta');

