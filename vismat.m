function vismat(A)
%
% This function visualizes a 2D matrix

[nrow, ncol] = size(A);

row = 1:nrow;
col = 1:ncol;

[Row,Col] = meshgrid(row,col);
At = A';

mesh(Row,Col,At)
view(60,30)
colormap(jet)

axis([1 nrow 1 ncol min(min(A)) max(max(At))])

sr = int2str(nrow);
sc = int2str(ncol);
title([sr,'x',sc,' matrix'])

xlabel('row index')
ylabel('col index')
zlabel('element')

