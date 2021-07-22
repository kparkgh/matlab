function [amax,i,j] = maxij(a)

[colmax,ii]= max(a);
[amax,j] = max(colmax);
i = ii(j);
