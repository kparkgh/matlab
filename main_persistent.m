% main_persistent

x = 1;
disp('Use persistent data from previous function call of fn_persistent?')
disp('[1: yes, enter: no]')
ans = input('-->  ');

if ~isequal(ans,1) % ~= does not work correctly since ([] ~= 1) gives []
    clear fn_persistent
end

for i = 1 : 10
    
    k = i - 1;
    y = fn_persistent(k,x)

end