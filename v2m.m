function [X,Y,Z] = v2m(x,y,z)

% This function converts the vectors x, y, z of the same length into
% arrays X, Y, Z for mesh or contour plotting.

X = unique(x); % top vector
Y = unique(y); % left vector

n = length(X);
m = length(Y);

Z = zeros(m,n); % initialize Z matrix

% make Z matrix whose dimension = dim(Y) x dim(X) so that we can implement
% contour(X,Y,Z)
for j = 1:n
    
    ii = ( x == X(j) ); % ii comes out as a logical vector
    
    % make j-th column of Z

    % when there is only one element of x s.t. x == X(j)
    % (interp1 requires at least two data points)
    if ( sum(ii) == 1 ) 
        i = ( Y == y(ii) );
        Z(:,j) = NaN;
        Z(i,j) = z(ii); % i is logical, j is numerical
    else
        Z(:,j) = interp1(y(ii),z(ii),Y,'linear',NaN);
    end
    
end
