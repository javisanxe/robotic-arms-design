function TRAY = CD(q)

n = size(q,1);
TRAY = zeros(4,4,n);
L1=0.45;
L2=0.45;

for i=1:n
    
    q1 = q(i,1);
    q2 = q(i,2);
    
    TRAY(:,:,i) = eye(4);

    TRAY(1,4,i) = L1*cos(q1)+L2*cos(q1+q2);
    TRAY(2,4,i) = L1*sin(q1)+L2*sin(q1+q2);
end



   