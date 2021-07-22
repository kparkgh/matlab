function y = fn_persistent(k,x)

% k: = 0 means this function is called for the first time
% y = A*x^2 + B*x

% If the persistent variable does not exist the first time you issue 
% the persistent statement, it is initialized to the empty matrix
persistent A B

if isempty(A) & isempty(B) % this first this function is called
    
    A = 1;
    B = 1;
    
else
    
    A = A + 1;
    B = B + 2;
    
end

y = A*x + B*x;