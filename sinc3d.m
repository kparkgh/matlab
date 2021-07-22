% sinc3d.m

x = -10 : 0.5 : 10;
y = -8 : 0.5 : 8;

[ X , Y ] = meshgrid( x , y );
r = sqrt( X.^2 + Y.^2 ) + eps;
Z = sin(r) ./ r;
mesh(X,Y,Z)

disp('This program generates and plots X, Y and Z')
disp('Try surf(X,Y,Z)')