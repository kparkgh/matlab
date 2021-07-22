% batchascii.m
%
% Description of input ascii file
%
%  - first row contains string of 73 letters.
%  - second row is blank.
%  - third row and below contains data with 5 columns, but number of rows is not known.

filename = input('Type ascii file name (ex. output1.txt,output2.txt) --> ','s');

fid = fopen(filename,'r'); % open file

nd = 5; % number of columns of the data 

s = fgetl(fid); % first read the string part in the first row

% Read the remaining data part.
% Without size, fscanf reads all the remaining part in row major
%   and gives the output in a column vector

x = fscanf(fid,'%e'); 
md = length(x)/nd; % find the number of rows of the data

X = zeros(nd,md); % first form a nd-by-md matrix (will be transposed later)
X(:) = x; % convert the vector into a matrix
X = X'; % transpose X to get the final matrix

s
X