
for i=1:1:306

    if qa(i,1)>2*pi
    
    qa(i,1)=qa(i,1)-2*pi;
    end
end

qa(:,1)=qa(:,1)-2*pi;

qa(1:7,1)=qa(1:7,1)-2*pi;
qa(1:18,1)=qa(1:18,1)-2*pi;

320

qa(320:327,1)=qa(320:327,1)+2*pi;