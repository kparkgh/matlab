%  File name: main_bicycle2.m

global m Izz lf lr % vehicle parameters
global Cf Cr % tire parameters

%%%%%%  Set initial data  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% vehicle parameters (global)
m = 2045;
Izz = 5428;
lf = 1.488;
lr = 1.712;

% tire parameters (global)
Cf = 38925;
Cr = 38255;

% data for numerical integration
t0 = 0; % initial time for integration
tf = 20; % final time for integration
N = 1000; % number of time points
tspan = [0:N]*tf/N;

%%%%%%  Simulation of bicycle model with no control %%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('simulating ...')

xp0 = zeros(6,1); % initial condition for state
xp0(1) = 80/3.6; % initial vehicle speed [m/s]

[tp,xp] = ode45(@bicycle2,tspan,xp0);

disp('simulation completed.')

%%%%%%  Plot  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all

subplot(2,2,1)
plot(tp,xp(:,2))
grid
title('J-turn test')
ylabel('vy [m/s]')

subplot(2,2,3)
plot(tp,180/pi*xp(:,3))
grid
xlabel('t [sec]')
ylabel('gamma [deg/s]')

subplot(1,2,2)
plot(xp(:,4),xp(:,5),'r.')
grid
xlabel('x [m]')
ylabel('y [m]')
axis equal