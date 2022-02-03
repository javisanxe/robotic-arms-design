
function instante = primer_valor_no_nulo(offset)

instante = 0;

for i=1:length(offset)
    if instante ~= 0 break
    end
    if offset(i) ~= 0
        instante = i;
    end
end

if instante == 0,
    instante = 1;
end



 
    