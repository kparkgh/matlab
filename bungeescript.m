% bungeescript.m

% set x0 in the 1/s block for x
m= 90;
a1= 1;
a2= 1;
g= 10;

for k=1:50;

    disp(['k = ',num2str(k)])
    [t,x,y]=sim('bungee_outport');

    if min(y)>0
        break
    end
end

disp(['Safe k = ',num2str(k)])
