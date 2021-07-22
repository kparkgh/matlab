function [xe,ye] = find_edge1(xa,ya)

% [xe,ye] = find_edge1(xa,ya)
% This function finds the edge points so that they include all the points
% inside the polygon formed by them. To find the edge points, angle is used.
% The edge angles of the polygon formed by the edge points do not exceed 180 deg.
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
xmax = max(x);
xmin = min(x);
i = 1:length(x);

%===============================================================================
% Find starting edge point (= rightmost point).
% When there are more than one rightmost point, the one with the smallest y is chosen.

i1 = ( x == xmax ); % i1 is a logical vector
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
% If there are more than one leftmost points, highest and then lowest points are selected.


% Edge points are found by angle from the current edge point to the next. 
% No arrangement is made for the case when there are more than one points with
% the same angle. Hence depending on order of points, nearer one may not be
% chosen.

% continue until there is no point left to the current edge point
while sum(x <= xnow) > 0 % = is for the case of multiple rightmost and leftmost points

    ileft = (x <= xnow);

    phi = 2*pi; % initialize angle 
    x1 = [];
    y1 = [];
    for ii = i(ileft)
    
        phi_ii = atan2(y(ii)-ynow,x(ii)-xnow);
        if ( phi_ii < 0 )
            phi_ii = phi_ii + 2*pi; % atan2 give values in [-pi,pi]
        end
        if ( phi_ii < phi )
            phi = phi_ii;
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

    % When there are more than one leftmost points, select lowest point as next edge
    if ( xnow == xmin )
        ileft = ( x == xnow );
        if ( sum(ileft) > 0 )
            ynow = min( y(ileft) );
            x(ileft) = []; % update x
            y(ileft) = []; % update y
            i = 1:length(x); % update i 
            xe = [xe; xnow]; % update xe
            ye = [ye; ynow]; % update ye
        end
    end
    
    
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

    phi = 2*pi; % initialize angle
    x1 = [];
    y1 = [];
    for ii = i(iright)
    
        phi_ii = atan2(y(ii)-ynow,x(ii)-xnow);
        if ( phi_ii < phi )
            phi = phi_ii;
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
% Determin whether or not to drop the last points to make all edge angles less
% than 180 degrees.
while 1 % infinite loop
%     phi = atan2(ye(1)-ye(end),xe(1)-xe(end));
%     if ( phi < 0 )
%         xe(end) = [];
%         ye(end) = [];
%     else
%         break
%     end
    phi1 = atan2(ye(1)-ye(end),xe(1)-xe(end));
    phi2 = atan2(ye(end)-ye(end-1),xe(end)-xe(end-1));
    if ( phi1 < phi2 )
        xe(end) = [];
        ye(end) = [];
    else
        break
    end
end

% fill(xe,ye,'y')
% axis([min(xe)*0.9 max(xe)*1.1 min(ye)*0.9 max(ye)*1.1])
% hold on
% plot(xe,ye,'ro')
% plot(xa,ya,'*')
% hold off