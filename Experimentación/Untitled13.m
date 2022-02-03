%Experimento

figure()
plot(xy(:,2),-xy(:,1))

for k=1:2
for j=2:length(t)-2
    
    if qa(j,k)-qa(j+1,k)>pi
        
        qa(j+1,k)=qa(j+1,k)+2*pi;
    end
    
    if qa(j+1,k)-qa(j,k)>pi
        
        qa(j+1,k)=qa(j+1,k)-2*pi;
    end
end
end

figure()
subplot(2,1,1)
plot(t,qa(:,1))

subplot(2,1,2)
plot(t,qa(:,2))

figure()
subplot(2,1,1)
plot(t,qp(:,1),'b')

subplot(2,1,2)
plot(t,qp(:,2),'r')

td=t_d(1:28001)'

figure()
subplot(2,1,1)
plot(td,q_d(:,1))

subplot(2,1,2)
plot(td,q_d(:,2))

%%%
figure()
subplot(2,1,1)
plot(td,qp_d(:,1))

subplot(2,1,2)
plot(td,qp_d(:,2))

%%%
figure()
subplot(2,1,1)
plot(td,qpp_d(:,1))

subplot(2,1,2)
plot(td,qpp_d(:,2))


figure()
plot(xyfinal(:,2),-xyfinal(:,1))






