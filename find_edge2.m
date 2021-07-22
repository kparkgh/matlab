function [xe,ye] = find_edge2(xa,ya)

% [xe,ye] = find_edge2(xa,ya)
% This function finds the edge points so that they include all the points
% inside the polygon formed by them.
% To find the edge points, shortest distance is used.
%
% Input
%  xa: x vector
%  ya: y vector (xa and ya must have the same length)
%
% Output
%  xe: x vector for the edge points
%  ye: y vector for the edge points
%
%  Note that (xe,ye) are in ccw order starting from the rightmost point. When there
%  are more than one rightmost point, the one with the smallest y is chosen.
%

xe = [];
ye = [];

n = length(xa);
if n ~= length(ya)
    error('xa and ya must be of the same length.')
end

x = xa;
y = ya;
i = 1:length(x);

%===============================================================================
% Find starting edge point (= rightmost point).
% When there are more than one rightmost point, the one with the smallest y is chosen.

i1 = ( x == max(x) ); % i1 is a logical vector
x1 = x(i1);
y1 = y(i1);
ii = i(i1); % ii is a numerical variable

if ( sum(i1) > 1 ) % when there are more than one rightmost points 
    k = ( y1 == min(y1) ); % k is a logical vector
    x1 = x1(k);
    y1 = y1(k);
    ii = ii(k); % ii is a numerical variable (can be a vector)
end

xnow = x1(1); % in case there are multiple points in the same location
ynow = y1(1); % in case there are multiple points in the same location

x(ii) = []; % update x by dropping xnow (can be more than one point) from x
y(ii) = []; % update y by dropping ynow (can be more than one point) from y
i = 1:length(x); % update i 

xe = [xe; xnow]; % update xe
ye = [ye; ynow]; % update ye

%===============================================================================
% Find upper edge points. Upper edge points include points located from the
% starting point to the leftmost point when moving ccw (starting point is excluded).

% Edge points are found by angle from the current edge point to the next. 
% No arrangement is made for the case when there are more than one points with
% the same angle. Hence depending on order of points, nearer one may not be
% chosen.

% continue until there is no point left to the current edge point
while sum(x <= xnow) > 0 

    ileft = (x <= xnow);

    gap = inf; % initialize distance 
    x1 = [];
    y1 = [];
    for ii = i(ileft)
    
        gap_ii = sqrt( (x(ii)-xnow)^2 + (y(ii)-ynow)^2 );
        if ( gap_ii < gap )
            gap = gap_ii;
            x1 = x(ii);
            y1 = y(ii);
            i1 = i(ii);
        end
    
    end
   
    xnow = x1;
    ynow = y1;
    x(i1) = []; % update x by dropping xnow from x
    y(i1) = []; % update y by dropping ynow from y
    i = 1:length(x); % update i 
    xe = [xe; xnow]; % update xe
    ye = [ye; ynow]; % update ye

end

%===============================================================================
% Find lower edge points. Lower edge points include points located from the
% the leftmost point to the starting point when moving ccw (starting point is excluded).

% Edge points are found by angle from the current edge point to the next. 
% No arrangement is made for the case when there are more than one points with
% the same angle.

% continue until there is no point right to the current edge point
while sum( (xnow < x) & (x < xe(1)) ) > 0 

    iright = (xnow < x) & (x < xe(1));

    gap = inf; % initialize distance 
    x1 = [];
    y1 = [];
    for ii = i(iright)
    
        gap_ii = sqrt( (x(ii)-xnow)^2 + (y(ii)-ynow)^2 );
        if ( gap_ii < gap )
            gap = gap_ii;
            x1 = x(ii);
            y1 = y(ii);
            i1 = i(ii);
        end
    
    end
   
    xnow = x1;
    ynow = y1;
    x(i1) = []; % update x by dropping xnow from x
    y(i1) = []; % update y by dropping ynow from y
    i = 1:length(x); % update i 
    xe = [xe; xnow]; % update xe
    ye = [ye; ynow]; % update ye

end

fill(xe,ye,'y')
hold on
plot(xe,ye,'ro')
plot(xa,ya,'*')
hold off