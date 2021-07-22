% batchascii2.m
%
% 입력파일이 가져야 할 규칙
%
%  - 파일에는 문자부분과 함께 2개의 데이터 부분이 있다.
%  - 첫번째 데이터부분은 [Data1]이라는 문자 아래에 있다.
%  - 두번째 데이터부분은 [Data2]이라는 문자 아래에 있다.

% 입력파일의 이름을 사용자로부터 받아서, 그 파일을 읽기로 연다.
filename = input('Type ascii file name (ex. output3.txt) --> ','s');
fid = fopen(filename,'r'); % open file

% [Data1]이라는 문자가 들어 있는 부분을 찾는다.
% 왜냐하면, file position indicator를 그 다음으로 옮겨 놓기 위해서
while 1 % infinite loop
    s = fgetl(fid);
    if   isequal(s,'[Data1]')
        break
    end
end
A = fscanf(fid,'%e')

% [Data2]이라는 문자가 들어 있는 부분을 찾는다.
% 왜냐하면, file position indicator를 그 다음으로 옮겨 놓기 위해서
while 1 % infinite loop
    s = fgetl(fid);
    if   isequal(s,'[Data2]')
        break
    end
end
B = fscanf(fid,'%e')