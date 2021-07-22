function [X,Y,Z,xx,yy,zz,Xaug,Yaug,Zaug] = hist2real(x,y,nx,ny)

% This function plots 2D histogram for a data set of (x, y).
% (You can try hist2integer when x and y are integers)
%
% Input
%   x : input vector (length of x must be equal to length of y)
%   y : input vector (see above)
%   nx: number of bins for x
%       if nx = 3, 3 intervals are as follows:
%                 xmin   <=   1st interval  <=   (xmax-xmin)/3
%       (xmax-xmin)/3    <    2nd interval  <=   (xmax-xmin)*2/3
%       (xmax-xmin)*2/3  <    3rd interval  <=   xmax
%   ny: number of bins for y (see description of nx)
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
%   Xaug : 3*nx-by-1 vector containing augmented version of X
%   Yaug : 3*ny-by-1 vector containing augmented version of Y
%   Zaug : 3*ny-by-3*nx matrix containing augmented version of Z

if ( length(x) ~= length(y) )
    error('The lengths of x and y must be equal in hist2.')
end
N = length(x); 

xmin = min(x); xmax = max(x);
dx = (xmax - xmin) / nx;

ymin = min(y); ymax = max(y);
dy = (ymax - ymin) / ny;

X = xmin + [0:(nx-1)]*dx; % do not change this to xmin:dx:xmax
Y = ymin + [0:(ny-1)]*dy; % same as above
Z = zeros(ny,nx); % initialize occurrence count

for k = 1:N
   
    xk = x(k);
    yk = y(k);
    
    % find the interval index to which xk and yk belong to
    xk = xk - dx/2*(xk == xmax); % without this, ix is wrong when xk = xmax
    yk = yk - dy/2*(yk == ymax);
    ix = floor( (xk - xmin) / dx ) + 1;
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

%% augment Z with NaNs so that 3D bar graph can be drawn

Zaug = nan(3*ny,3*nx); % intialize Zaug with NaNs
for i = 1:ny
    for j = 1:nx
        Zaug(3*i-2:3*i-1,3*j-2:3*j-1) = Z(i,j)*ones(2);
    end
end

Xaug = [X ;  X+dx ; X+dx ];
Xaug = Xaug(:); 

Yaug = [Y ;  Y+dy ; Y+dy ];
Yaug = Yaug(:); 

%% figure

close all
figure(1)
surf(Xaug,Yaug,Zaug)
xlabel('x'); ylabel('y')
colorbar; colormap('hot')
view(0,90)

figure(2)
surf(Xaug,Yaug,Zaug)
colorbar; colormap('hot')
hold on
stem3(Xaug,Yaug,Zaug,'.')
hold off
xlabel('x'); ylabel('y')

