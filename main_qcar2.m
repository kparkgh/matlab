
% This is a main matlab program for simulation of a quarter-car model with and without on/off skyhook.

%%%%%%  Define global variables  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global ms mu ks kt % vehicle parameters 
global height duration % road profile parameters
global cpass csoft chard % damper parameters

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
chard = 2000;
csoft = 1000;

% data for numerical integration
t0 = 0; % initial time for integration
tf = 3; % final time for integration
N = 500; % number of time points
tspan = [0:N]*tf/N;

%%%%%%  Simulation of passive damper system  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('simulating passive system ...')
xp0 = zeros(4,1); % initial condition for passive damper system

[tp,xp] = ode45(@qcar1,tspan,xp0); % qcar1 defines passive system

% compute sprung mass acceleration
ddzsp = (-ks/ms)*(xp(:,1)-xp(:,3)) - (cpass/ms)*(xp(:,2)-xp(:,4));

disp('simulation completed.')

%%%%%%  Simulation of system with on/off skyhook controller  %%%%%%%%%%%%%%%%%%%

disp('simulating skyhook system ...')
xs0 = zeros(4,1); % initial condition of state variables for skyhook system

[ts,xs] = ode45(@qcar2,tspan,xs0); % qcar2 defines skyhook system

% compute what the damping coefficient was at each instant of xs.
cskys = [ ];
for i = 1:length(ts)
   ctmp = csoft;
   if ( xs(i,2)*(xs(i,2)-xs(i,4)) > 0 )
      ctmp = chard;
   end
   cskys = [cskys; ctmp];
end

% compute sprung mass acceleration
ddzss = (-ks/ms)*(xs(:,1)-xs(:,3)) - (cskys/ms).*(xp(:,2)-xp(:,4));

disp('simulation completed.')

%%%%%%  Plot  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(tspan,ddzsp,'b-',tspan,ddzss,'r-')
grid
title('Comparison of vertical acceleration of sprung mass')
xlabel('t [sec]')
ylabel('vertical acc. [m/s^2]')
legend('passive','on/off skyhook')

