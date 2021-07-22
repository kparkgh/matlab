N = input('Type N  -->  ');

n4all = [];
n4 = 0
for i = 1:N
    a = ceil(rand*6);
    if a == 4
        n4 = n4 + 1;
    end
    n4all = [n4all n4/i];
end

plot([1:N],n4all,'.-',[1 N],[1/6 1/6])