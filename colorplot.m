function colorplot(x,y,yref)

% function colorplot(x,y,yref)
%
% This function plots (x,y) along with reference graph of (x,yref).
% The area where y > yref is colored red, and the area when y < yref is
% colored blue.
%
% All input vectors must be column vectors of the same length.
%

% check error whether input vectors are column vectors
if ( isrow(x) | isrow(y) | isrow(yref) )
    error('Error in function colorplot. All input vectors must be column vectors!!')
end

% [0 0 1]: blue, [1 1 1]: white, [1 0 0]: red
color_low = [0 0 1]; % color code for lower-than-reference part
color_bottom = [1 1 1]; % color code for bottom part
color_high = [1 0 0]; % color code for higher-than-reference part

% form color code matrix for color bar
map = [color_bottom ; color_high ; color_low];

ymax = max([ y' ; yref' ])';
ymin = min([ y' ; yref' ])';

dymax = ymax - yref; % positive
dymin = ymin - yref; % negative

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all

figure('Name','Fig 1: 원 데이터를 그대로 사용한 경우','NumberTitle','off')

subplot(2,2,1)
plot(x,y,'m.-',x,yref,'g.-')
legend('y','y_{ref}')

subplot(2,2,3)
plot(x,ymax,'r.-',x,ymin,'b.-')
legend('y_{max}','y_{min}')

subplot(1,2,2)
% find proper range of y axis
thickness = max(ymin)-min(ymin);
ylow = min(ymin) - thickness/3;
ylow = floor(ylow);
yhigh = max(ymax) + thickness/5;
yhigh = ceil(yhigh);

area(x,[yref dymax dymin],ylow)
colormap(map)
axis([-inf inf ylow yhigh])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   augment x so that x contains line crossing points and then augment y
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = length(x);
ydiff = y - yref;

xc = [];
for i = 1 : N-1
    if ( ydiff(i)*ydiff(i+1) < 0 ) % when sign changes
        den = abs(ydiff(i)) + abs(ydiff(i+1));
        num = abs(ydiff(i));
        xtmp = x(i) + num/den*(x(i+1)-x(i));
        xc = [xc; xtmp];
    end
end

xa = [x; xc];
xa = sort(xa);

ya = interp1(x,y,xa);
yaref = interp1(x,yref,xa);

yamax = max([ ya' ; yaref' ])';
yamin = min([ ya' ; yaref' ])';

dyamax = yamax - yaref; % positive
dyamin = yamin - yaref; % negative

figure('Name','Fig 2: 그래프 교차점에서의 그림을 개선하기 위해 데이터를 보정한 경우','NumberTitle','off')

subplot(2,2,1)
plot(xa,ya,'m.-',xa,yaref,'g.-')
legend('y','y_{ref}')

subplot(2,2,3)
plot(xa,yamax,'r.-',xa,yamin,'b.-')
legend('y_{max}','y_{min}')

subplot(1,2,2)
area(xa,[yaref dyamax dyamin],ylow)
colormap(map)
axis([-inf inf ylow yhigh])

