
% This is a main matlab program for simulation of a quarter-car model.

%%%%%%  Define global variables  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global ms mu ks kt % vehicle parameters 
global height duration % road profile parameters
global cpass % damper parameters

%%%%%%  Set initial data  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% quarter-car model (global)
ms = 337;
mu = 55;
ks = 22750;
kt = 245000;

% data for a bump road (global)
height = 0.1; % [m]
duration = 0.5; % [sec]

% damper model (global)
cpass = 2000;

% data for numerical integration
t0 = 0; % initial time for integration
tf = 3; % final time for integration
N = 500; % number of time points
tspan = [0:N]*tf/N;

%%%%%%  Simulation of passive damper system  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('simulating passive system ...')
xp0 = zeros(4,1); % initial condition for passive damper system

close all
subplot(2,1,1)
options = odeset('OutputFcn',@odeplot);
[tp,xp] = ode45(@qcar1,tspan,xp0,options); % qcar1 defines passive system
legend(['x1';'x2';'x3';'x4'])

% compute sprung mass acceleration
ddzsp = (-ks/ms)*(xp(:,1)-xp(:,3)) - (cpass/ms)*(xp(:,2)-xp(:,4));

disp('simulation completed.')

%%%%%%  Plot  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,1,2)
plot(tspan,ddzsp,'b-')
grid
xlabel('t [sec]')
ylabel('vertical acc. [m/s^2]')
legend('passive')

