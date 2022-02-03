
function qp_ls = minimos_cuadrados_var(q_orig,t,a,n_puntos)

n=size(q_orig,1);
qp_ls=zeros(n,2);

% Puntos iniciales del intervalo de tiempos:

if n_puntos==7
    % Punto inicial del intervalo de tiempos:
    qp_ls(1,a)=0;

    % Segundo punto del intervalo de tiempos:
    x = [t(1) t(2) t(3)];
    y = [q_orig(1,a) q_orig(2,a) q_orig(3,a)];
    [A,b] = matrices(x,y);
    %coef = inv(A'*A)*A'*b;
    coef=A\b;
    qp_ls(2,a)=2*coef(1)*t(2) + coef(2);

    % Tercer punto del intervalo de tiempos:
    x = [t(1) t(2) t(3) t(4) t(5)];
    y = [q_orig(1,a) q_orig(2,a) q_orig(3,a) q_orig(4,a) q_orig(5,a)];
    [A,b] = matrices(x,y);
    %coef = inv(A'*A)*A'*b;
    coef=A\b;
    qp_ls(3,a)=2*coef(1)*t(3) + coef(2);
end

if n_puntos==5
    % Punto inicial del intervalo de tiempos:
    qp_ls(1,a)=0;

    % Segundo punto del intervalo de tiempos:
    x = [t(1) t(2) t(3)];
    y = [q_orig(1,a) q_orig(2,a) q_orig(3,a)];
    [A,b] = matrices(x,y);
    %coef = inv(A'*A)*A'*b;
    coef=A\b;
    qp_ls(2,a)=2*coef(1)*t(2) + coef(2);
end

if n_puntos==3
    % Punto inicial del intervalo de tiempos:
    qp_ls(1,a)=0;
end




% Puntos interiores del intervalo de tiempos:

n_ini = floor(n_puntos/2)+1;
n_fin = n-floor(n_puntos/2);

if n_puntos==7,
    for i=n_ini:n_fin,
        x = [t(i-3) t(i-2) t(i-1) t(i) t(i+1) t(i+2) t(i+3)];
        y = [q_orig(i-3,a) q_orig(i-2,a) q_orig(i-1,a) q_orig(i,a) q_orig(i+1,a) q_orig(i+2,a) q_orig(i+3,a)];
        [A,b] = matrices(x,y);
        % coef = inv(A'*A)*A'*b;
        coef=A\b;
        qp_ls(i,a)=2*coef(1)*t(i) + coef(2);
    end
end
    
if n_puntos==5,
    for i=n_ini:n_fin,
        x = [t(i-2) t(i-1) t(i) t(i+1) t(i+2)];
        y = [q_orig(i-2,a) q_orig(i-1,a) q_orig(i,a) q_orig(i+1,a) q_orig(i+2,a)];
        [A,b] = matrices(x,y);
        % coef = inv(A'*A)*A'*b;
        coef=A\b;
        qp_ls(i,a)=2*coef(1)*t(i) + coef(2);
    end
end

if n_puntos==3,
    for i=n_ini:n_fin,
        x = [t(i-1) t(i) t(i+1)];
        y = [q_orig(i-1,a) q_orig(i,a) q_orig(i+1,a)];
        [A,b] = matrices(x,y);
        % coef = inv(A'*A)*A'*b;
        coef=A\b;
        qp_ls(i,a)=2*coef(1)*t(i) + coef(2);
    end
end


% Puntos finales del intervalo de tiempos:

if n_puntos==7
    % Antepenúltimo punto del intervalo de tiempos:
    x = [t(n-4) t(n-3) t(n-2) t(n-1) t(n)];
    y = [q_orig(n-4,a) q_orig(n-3,a) q_orig(n-2,a) q_orig(n-1,a) q_orig(n,a)];
    [A,b] = matrices(x,y);
    % coef = inv(A'*A)*A'*b;
    coef=A\b;
    qp_ls(n-2,a)=2*coef(1)*t(n-2) + coef(2);

    % Penúltimo punto del intervalo de tiempos:
    x = [t(n-2) t(n-1) t(n)];
    y = [q_orig(n-2,a) q_orig(n-1,a) q_orig(n,a)];
    [A,b] = matrices(x,y);
    % coef = inv(A'*A)*A'*b;
    coef=A\b;
    qp_ls(n-1,a)=2*coef(1)*t(n-1) + coef(2);

    % Último punto del intervalo de tiempos:
    qp_ls(n,a)=0;
end

if n_puntos==5
    % Penúltimo punto del intervalo de tiempos:
    x = [t(n-2) t(n-1) t(n)];
    y = [q_orig(n-2,a) q_orig(n-1,a) q_orig(n,a)];
    [A,b] = matrices(x,y);
    % coef = inv(A'*A)*A'*b;
    coef=A\b;
    qp_ls(n-1,a)=2*coef(1)*t(n-1) + coef(2);

    % Último punto del intervalo de tiempos:
    qp_ls(n,a)=0;
end

if n_puntos==3
    % Último punto del intervalo de tiempos:
    qp_ls(n,a)=0;
end










