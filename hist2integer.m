function [X,Y,Z,xx,yy,zz] = hist2integer(x,y,nx,ny)

% This function plots 2D histogram for an integer data set of (x, y).
% (when x and y are real numbers, hist2real is recommended)
%
% Input
%   x : input vector (length must be equal to y)
%   y : input vector (length must be equal to x)
%   nx: number of x intervals for the histogram
%       (if nx = 3, 3 intervals are [xmin,(xmax-xmin)/2),
%       [(xmax-xmin)/2,xmax), [xmax,xmax], that is the last interval is
%       always xmax.)
%   ny: number of y intervals for the histogram (see description of nx)
%
% Output
%   X : 1-by-nx vector containing first values of x intervals
%   Y : 1-by-ny vector containing first values of y intervals
%   Z : ny-by-nx matrix containing occurrence counts
%       Z(i,j) is number of occurrence of X(j)-interval and Y(i)-interval
%       The reason why Z is not made nx-by-ny is for using surf function.
%   xx, yy: column vectors that contain only (X,Y) elements that occurred
%           at least once
%   zz: column vector of the same length as xx and yy containing
%       numbers of occurrence of (xx,yy)

if ( length(x) ~= length(y) )
    error('The lengths of x and y must be equal in hist2integer.')
end
N = length(x); 

xmin = min(x);
xmax = max(x);
dx = (xmax - xmin) / (nx-1);

ymin = min(y);
ymax = max(y);
dy = (ymax - ymin) / (ny-1);

X = xmin + [0:(nx-1)]*dx; % do not change this to xmin:dx:xmax
Y = ymin + [0:(ny-1)]*dy; % same as above
Z = zeros(ny,nx); % initialize occurrence count

for k = 1:N
   
    xk = x(k);
    yk = y(k);
    
    % find the interval index to which xk and yk belong to
    ix = floor( (xk - xmin) / dx ) + 1 ;
    iy = floor( (yk - ymin) / dy ) + 1;
    
    Z(iy,ix) = Z(iy,ix) + 1; % increase occurrence count of (ix,iy)-interval 
    
end

% convert a matrix into a vector
[XX,YY]=meshgrid(X,Y);
xx = XX(:); % make ny-by-nx matrix into ny*nx-by-1 vector
yy = YY(:); % same as above
zz = Z(:); % same as above

i = ( zz > 0 ); % i is true only for intervals that occurred at least once

xx = xx(i); % leave only x elements that occurred at least once
yy = yy(i); % same as above
zz = zz(i); % leave only positive occurrence elements

%----- figure using surf --------------------------------------------------

figure(1)
whitebg('w')
surf(X,Y,Z)
xlabel('x'); ylabel('y')
colorbar; colormap('jet')

%----- figure using stem3 -------------------------------------------------

figure(2)
stem3(X,Y,Z,'filled')
xlabel('x'); ylabel('y')
zlabel('number of occurrence')

%----- figure using scatter -----------------------------------------------

figure(3)
scatter(xx,yy,50,zz,'filled')
xlabel('x'); ylabel('y')
colorbar; colormap('bone')

