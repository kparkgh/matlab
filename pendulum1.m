function dx = pendulum1(t,x)

% x(1): angle of pendulum [rad]
% x(2): angular velocity [rad/s]
%
%

dx = zeros(2,1);

dx(1) = x(2);
dx(2) = -sin(x(1));

