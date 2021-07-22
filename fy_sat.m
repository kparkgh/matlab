function fy = fy_sat(Calpha,mu,K,alpha)
%
% This function finds lateral tire force by simple saturation tire model.
%
%                mu        K
%   Fy = Calpha --- tan ( ---  alpha)
%                K         mu
%
% Input
%   Calpha: cornering stiffness
%   mu: road friction coefficient
%   K: model parameter
%   alpha: slip angle of tire [rad]
%
% Output
%   Fy: lateral tire force [N]

fy = Calpha*mu/K*atan(K*alpha/mu);
