function [out1,out2,out3] = ex_fun(in1,in2)
 
if ( nargin == 1 )
    in2 = 10;
end
 

if ( (in1 == 0) | (in2 < 0) )
   error('Invalid value of input in ex_fun')
end
 
out1 = 1/in1 + sqrt(in2);
if ( nargout == 1 ); return; end
 
out2 = 1/in1 + sqrt(in2)*exp(in2);
if ( nargout == 2 ); return; end
 
out3 = 1/in1 + sqrt(in2)*exp(in2)*cos(in2);
