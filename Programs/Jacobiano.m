%%Jacobiano

%Entrada: q,dq ??

%[dx;dy]=J*[dq1;dq2];
n = size(q,1);

L1=0.45;
L2=0.45;

velocidades=[];

for i=1:n
    
    q1 = q(i,1);
    q2 = q(i,2);
    
    dq1 = dq(i,1);
    dq2 = dq(i,2);
    
    %Jacobiano----------------------------------------
    J=[-L1*sin(q1)-L2*sin(q1+q2)  ,   -L2*sin(q1+q2);
        L1*cos(q1)-L2*cos(q1+q2)  ,    L2*cos(q1+q2)];
    
    velocidades[n,:]=(J*[dq1;dq2])'; 

    
end


