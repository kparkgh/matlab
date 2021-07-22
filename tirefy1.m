function Fy = tirefy1(Calpha,alpha)

% This function computes lateral force of a single tire 
%
% Input
%   Calpha: cornering stiffness of tire [N/rad]
%   alpha: tire slip angle [rad]
%
% Output
%   Fy: lateral tire force [N]

Fy = -Calpha*alpha;
