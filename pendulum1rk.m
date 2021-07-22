function [dx,y] = pendulum1rk(t,x)

% x(1): angle of pendulum [rad]
% x(2): angular velocity [rad/s]
%
%
global I_EVAL_Y

dx = zeros(2,1);

dx(1) = x(2);
dx(2) = -sin(x(1));

if ( I_EVAL_Y == 1 )
    y = dx;
end

