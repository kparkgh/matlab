% main_v2m.m

% Read data from "output1" sheet of "engineoutput.xls" 
disp('Reading data from engineoutput.xls ... ')
rpm = xlsread('engineoutput','output1','A3:A193');
bar = xlsread('engineoutput','output1','B3:B193');
kpa = xlsread('engineoutput','output1','C3:C193');
disp('Reading completed.')

rpm = round(rpm); % this is necessary to make rpm monotonically increasing

[X,Y,Z] = v2m(rpm,bar,kpa);

v = [11 22 34 47 61 75 88 100 110 130 150 170 190 205]; % values of desired contour labels
[a,b] = contour(X,Y,Z,v);
clabel(a,b)

xlabel('speed [rpm]')
ylabel('BMEP [bar]')

a = title('Contour of P_EX_1 [kPa]');
set(a,'Interpreter','None') % disable TeX conversion subscript 

