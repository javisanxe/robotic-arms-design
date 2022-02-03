
function [A,b] = matrices(x,y)

n = length(x);
A = ones(n,3);
b = zeros(n,1);

for i=1:n
    A(i,1)=x(i)^2;
    A(i,2)=x(i);
    b(i,1)=y(i);
end

