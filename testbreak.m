% testbreak.m

for i = 1 : 4
    for j = 1 : 5
   
        if j == 3
            break % change it to continue or return
        end
        
        disp([i j])
    end
end