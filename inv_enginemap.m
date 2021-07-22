function [throttle1] = inv_enginemap(rpm,throttle,torque,rpm1,torque1)

% function [throttle1] = inv_enginemap(rpm,throttle,torque,rpm1,torque1)
%
% 이 함수는 엔진맵이 2D Lookup Table 형태로 주어졌을 때,다음의 inverse 문제를 푼다
%
% known: rpm1, torque1
% unknown: throttle1
%
% 즉 현재의 rpm이 주어지고 (=rpm1), 원하는 엔진 출력 토크가 주어졌을 때 (= torque1),
% 이러한 출력 토크를 낼 수 있는 throttle값 (= throttle1)을 구해주는 함수
%
%%%% 입력 %%%%
% rpm: 2D 엔진맵의 rpm값 벡터 (길이 nx)
% throttle: 2D 엔진맵의 throttle값 벡터 (길이 ny)
% torque: 2D 엔진맵의 torque값 행렬 (ny-by-nx)
% rpm1: 현재 rpm값 (스칼라)
% torque1: 희망하는 torque값 (스칼라)
%
%%%% 출력 %%%%
% throttle1: 현재의 rpm값(= rpm1)에서, 원하는 엔진토크(= torque1)를 내기 위한
%            throttle값 (rpm1이나 torque1이 엔진맵의 범위를 벗어나면 NaN을 준다)
%
%%%% 검증 방법 %%%%
% 이 함수의 결과 throttle1이 맞는지 확인하기 위해 아래와 같이 해서 얻은 torque2가
% 이 함수의 입력으로 들어가는 torque1과 같은지 확인하면 된다.
%
% torque2 = interp2(rpm,throttle,torque,rpm1,throttle1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% torque1이 0이면 throttle1을 0으로 놓고 함수를 종료한다.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ( torque1 < 1e-10 )
    throttle1 = 0;
    close all
    return
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rpm1이 rpm의 최소값보다 작거나 최대값보다 크면 throttle1에 NaN을 주고, 함수 종료.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ( rpm1 < rpm(1) ) | (rpm1 > rpm(end) ) 
    throttle1 = NaN;
    close all
    return
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 주어진 rpm 벡터의 값들 중에서 rpm1을 포함하는 구간을 찾는다.
% rpm(iL) <= rpm1 < rpm(iU)
% (단 마지막 구간에 걸리는 경우에만 rpm(iL) < rpm1 <= rpm(iU))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if abs(rpm1 - rpm(end)) < 1e-10  % rpm1이 rpm의 마지막 값과 같은 경우
    iU = length(rpm);
else
    iU = 1;
    while ( rpm(iU) <= rpm1 ) % equal을 빼지 말것.
        iU = iU + 1;
    end
end
iL = iU - 1;

rpmL = rpm(iL);
rpmU = rpm(iU);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rpm1 값에서 주어진 throttle 벡터 값에서의 torque값들(= torqueN)을 구한다.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diffL = rpm1 - rpmL;
diffU = rpmU - rpm1;

torqueL = torque(:,iL);
torqueU = torque(:,iU);
torqueN = torqueL + diffL/(diffL+diffU)*(torqueU - torqueL);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% throttle에 대한 torqueN의 함수관계를 이용, interpolation을 통해 throttle1을 구한다.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

throttleN = throttle;

% interpolation을 하기 전에 torqueN 벡터 앞부분에 0이 한개보다 많이 있으면 한개만
% 남겨놓아야 한다. (현재 가지고 있는 엔진맵에서는 최대 3개까지 가능)
nzero = sum( torqueN == 0 );
if ( nzero > 1 )
    torqueN = torqueN(nzero:end);
    throttleN = throttleN(nzero:end);
end

throttle1 = interp1(torqueN,throttleN,torque1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot. 이해를 돕기 위한 부분으로 나중에 제거 가능.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
plot(rpm,torque,'.-')
legend(num2str(throttle'))
hold on

xlabel([ 'rpm1 = ' , num2str(rpm1) , ', torque1 = ' , num2str(torque1) ])
plot(rpm1*ones(size(torqueN)),torqueN,'o-')
plot(rpm1,torque1,'*')
title([ 'throttle1 = ' , num2str(throttle1) ])

hold off