function [qa,qb] = CI(TRAY)

n = size(TRAY,3);
L1=0.45;
L2=0.45;
qa=[];
qb=[];

% q = [];
% q_var = [];

for i=1:n
    
    x = TRAY(1,4,i);
    y = TRAY(2,4,i);

    % Modelo cinemático inverso robot 2gdl:
    
    %q1=beta-alfa
    %q2=atan2(sin(q2),cos(q2)) = atan2(+-sqrt(1-cos(q2)^2),cos(q2))
    
    beta  = atan2(y,x);
    cosq2 = (x^2+y^2-L1^2-L2^2)/(2*L1*L2);
    
    senq2A =  sqrt(1-cosq2^2);
    senq2B =- sqrt(1-cosq2^2);
    
    %DOS OPCIONES (+-)
    q2a = atan2( senq2A , cosq2);
    q2b = atan2( senq2B , cosq2);

    
    alfa1 = atan2(L2*senq2A,L1+L2*cosq2);
    alfa2 = atan2(L2*senq2B,L1+L2*cosq2);

    q1a = atan2(y,x) - alfa1;
    q1b = atan2(y,x) - alfa2;
    
    
    
    qa=[qa; q1a q2a];
    qb=[qb; q1b q2b];
%     
%     q_new1 = [q1a q2a];
%     q_new2 = [q1b q2b];
%     
    
    
    
%     if i~=1 && i~=N && (q_new2(1)==0 || q_new2(1)==2*pi || q_new2(1)==pi)
%         q_new2(1) = q_new2(1)- pi;
%     end
%     
%     if i~=1 && i~=N && q_new1(1)==pi
%         q_new1(1) = q_new1(1)- pi;
%     end
% 
%    q = [q;q_new1];
%    q_var = [q_var;q_new2];
%     
end

    
end

