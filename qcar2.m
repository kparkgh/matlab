function xdot = qcar2(t,x)

% This function defines dynamics of quarter-car model with on/off skyhook logic
% when passing a bump.
%
% Input
%  t: current time [sec]
%  x: 4-by-1 state vector
%    x(1): displacement of sprung mass [m]
%    x(2): velocity of sprung mass [m/s]
%    x(3): displacement of unsprung mass [m]
%    x(4): velocity of unsprung mass [m/s]
%
% Input via global variables (see main1.m for description)
%  ms, mu, ks, kt, chard, csoft
%
% Output
%  xdot: 4-by-1 vector that contains a time derivative of x
%
% Functions called
%  bump1

global chard csoft ks ms kt mu

% compute road height of bump at current time
zr = bump1(t);

% determine damping coefficient under on/off skyhook logic
cs = csoft;
if ( x(2)*(x(2)-x(4)) > 0 )
   cs = chard;
end

% define state equation
xdot(1,1) = x(2);
xdot(2,1) = (-ks/ms)*(x(1)-x(3)) - (cs/ms)*(x(2)-x(4));
xdot(3,1) = x(4);
xdot(4,1) = (ks/mu)*(x(1)-x(3)) + (cs/mu)*(x(2)-x(4)) - (kt/mu)*(x(3)-zr);
