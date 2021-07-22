% batchexcel.m
%
% Description of input Excel file
%
%  - only one cell contains the word "rpm"
%  - rpm vector (row vector) is located right next to "rpm"-cell
%  - length of rpm vector is not known
%  - there is no data to the right of rpm vector
%
%  - only one cell contains the word "throttle"
%  - throttle vector (row vector) is located right next to "throttle"-cell
%  - length of throttle vector is not known
%  - there is no data to the right of throttle vector
%
%  - only one cell contains the word "torque"
%  - 1st element of torque matrix is located next to and below of "torque"-cell
%  - dimension of torque matrix is (# throttle)x(# rpm)

filename = input('Type Excel file name without .xls (enginedata1,enginedata2) --> ','s');
sheetname = input('Type Sheet name (Sheet1) --> ','s');

[NUM,TXT,RAW]=xlsread(filename,sheetname);

[m,n] = size(RAW);  % find data region

for i = 1:m
    for j = 1:n

        % find the location of "rpm" which is 1x3 string array
        % rpm vector is stored right next to "rpm"-cell

        checksize = (size(RAW{i,j}) == [1 3]);
        if all(checksize) % true when data size is 1x3
            checkword = (RAW{i,j} == 'rpm');
            if all(checkword) % true when data contains 'rpm'
                rpm = [];
                for jj = j+1 : n % rpm vector is stored right next to 'rpm'
                    if isfinite(RAW{i,jj}) % read before NaN
                        rpm = [rpm, RAW{i,jj}];
                    end
                end
                nrpm = length(rpm); % length of rpm
                break  % skip the remaining part of i-th row of RAW
            end
        end
        
        % find the location of "throttle" which is 1x8 string array
        % throttle vector is stored right next to "throttle"-cell

        checksize = (size(RAW{i,j}) == [1 8]);
        if all(checksize) % true when data size is 1x8
            checkword = (RAW{i,j} == 'throttle');
            if all(checkword) % true when data contains 'throttle'
                throttle = [];
                for jj = j+1 : n
                    if isfinite(RAW{i,jj})
                        throttle = [throttle, RAW{i,jj}];
                    end
                end
                nthrottle = length(throttle); % length of throttle
                break  % skip the remaining part of i-th row of RAW
            end
        end
        
        % find the location of "torque" which is 1x6 string array
        % torque matrix is stored next to and below of "torque"-cell

        checksize = (size(RAW{i,j}) == [1 6]);
        if all(checksize) % true when data size is 1x6
            checkword = (RAW{i,j} == 'torque');
            if all(checkword) % true when data contains 'throttle'
                torque = zeros(nthrottle,nrpm);
                for ii = 1 : nthrottle
                    for jj = 1 : nrpm
                        torque(ii,jj) = RAW{i+ii,j+jj};
                    end
                end
                
                rpm
                throttle
                torque

                return  % stop the program when torque is obtained
            end
        end
        
    end
end

                
                
            
