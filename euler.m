function [ts,xs] = euler(dfun,tf,x0,dt)

% [ts,xs] = euler(dt,tf,x0,dfun) 
% This function solves IVP(Initial Value Problem) by Euler method.
% IVP: dx/dt = f(t,x) , x(0) = x0
%
% input 
%   dfun: function handle that computes dx/dt
%         dfun must have the format: function dx = dfun(t,x) 
%         x and dx must be column vectors
%   tf: final time 
%   x0: nx-by-1 vector. Initial condition of x.
%   dt: step size 
%
% output 
%   ts: 1-by-nt array containing time points. 
%   xs: nx-by-nt array containing states at above time points. 

t = 0;
x = x0;

ts = 0;
xs = x0;

tff = tf - 0.5*dt;

while t < tff
    
    x = x + dt*dfun(t,x);
    t = t + dt;
    
    ts = [ts, t];
    xs = [xs, x]; 
    
end


