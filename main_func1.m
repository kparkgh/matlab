% main_func1.m

x = input('Type Initial guess -->  ' );
i = 0;
fx = inf;
dx = 1.e-6;

while ( abs(fx) > 1e-8)
    i = i + 1;
    fx = func1(x);
    dfx = (func1(x+dx)-fx)/dx;  
    x = x - fx/dfx;
end;

% i
% x