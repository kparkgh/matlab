% main_v2m_contours.m

% 엑셀 파일로부터 데이트를 읽어들인다.
disp('Reading data from main_v2m_contours_data.xlsx ... ')
tot = xlsread('main_v2m_contours_data.xlsx','Sheet2','A3:F57');
rpms = tot(:,1);
rpm_unique = unique(rpms);
disp('Reading completed.')

% 클릭한 값들을 저장할 변수를 초기화한다
rpm_all  = [];
icam_all = [];
ecam_all = [];
torque_all = [];
apc_all = [];
cov_all = [];

format short g % fixed point로 데이터를 보여주기 위한 형식

while 1 % 무한 루프 (outer loop)
    
    % 원하는 rpm 값을 선택한다
    rpm_now = input(['\n Type rpm among: ', num2str(rpm_unique') , ...
    '\n Or just type enter to finish \n --> ']);

    if isempty( rpm_now ) % 그냥 enter를 친 경우
        break % outer loop를 끝낸다
    end
    
    i = ( rpm_now == rpms ); % i는 논리값으로 이루어진 벡터. 
    if sum(i) == 0
        disp(' ')
        disp(' You typed Invalid rpm! Type valid rpm again.')
        continue % rpms에 없는 값을 사용자가 입력한 경우 다음 iteration으로 건너뛴다
    end

    % 사용자가 선택한 rpm 값에 해당하는 데이터 부분만을 추출한다.
    torque = tot(i,2);
    apc    = tot(i,3);
    ecam   = tot(i,4);
    icam   = tot(i,5);
    cov    = tot(i,6);

    % column vector 형태의 x,y,z 데이터를 2D 테이블 형태를 위한 X,Y,Z 모양으로 변환함
    % 이 때 Z 행렬은 NaN을 포함할 수 있다. 즉 x,y의 조합에 해당하는 조건인데
    % 그 조건에 해당하는 z 값이 없는 경우, 그 위치의 에는 NaN이 할당된다.
    [ ICAM1 , ECAM1 , TORQUE ] = v2m( icam , ecam , torque );
    [ ICAM2 , ECAM2 , APC ]    = v2m( icam , ecam , apc );
    [ ICAM3 , ECAM3 , COV ]    = v2m( icam , ecam , cov );

    close all

    subplot(2,2,1)
    [a,b] = contourf( ICAM1 , ECAM1 , TORQUE );
    clabel(a,b)
    xlabel('ICAM'); ylabel('ECAM')
    title(['TORQUE (RPM = ' , num2str(rpm_now) , ')'  ])
    hold on % subplot의 경우 hold on은 각각의 subplot에 대해 해줘야 함

    subplot(2,2,2)
    [a,b] = contourf( ICAM2 , ECAM2 , APC );
    clabel(a,b)
    xlabel('ICAM'); ylabel('ECAM')
    title(['APC (RPM = ' , num2str(rpm_now) , ')' ])
    hold on % subplot의 경우 hold on은 각각의 subplot에 대해 해줘야 함

    subplot(2,2,3)
    [a,b] = contourf( ICAM3 , ECAM3 , COV );
    clabel(a,b)
    xlabel('ICAM'); ylabel('ECAM')
    title(['COV (RPM = ' , num2str(rpm_now) , ')' ])
    hold on % subplot의 경우 hold on은 각각의 subplot에 대해 해줘야 함

    while 1 % 무한 루프 (inner loop)

        % 세 그림 중, 아무 그림 위에다 클릭하도록 안내한다
        disp('Click on any plot or just type enter to go to different rpm -->')
        [ icam_now , ecam_now ] = ginput(1);

        if isempty(icam_now) % 그림 위를 클릭을 하지 않고, 그냥 Enter를 쳤을 때
            break
        end
        
        % 방금 위에서 마우스로 클릭한 점에서의 torque, apc, cov 값을 보간법으로 구한다.
        torque_now = interp2( ICAM1 , ECAM1 , TORQUE , icam_now , ecam_now );
        apc_now    = interp2( ICAM2 , ECAM2 , APC , icam_now , ecam_now );
        cov_now    = interp2( ICAM3 , ECAM3 , COV , icam_now , ecam_now );

        % 클릭한 값들을 모아서 *_all 이라는 변수에 넣는다.
        rpm_all    = [rpm_all; rpm_now];
        icam_all   = [icam_all; icam_now];
        ecam_all   = [ecam_all; ecam_now];
        torque_all = [torque_all; torque_now];
        apc_all    = [apc_all; apc_now];
        cov_all    = [cov_all; cov_now];

        % 지금 클릭한 점에서 보간법으로 계산한 데이터를 보여준다 (지금까지 누적된 데이터와 함께)
        disp('[        rpm_all    icam_all     ecam_all     torque_all   apc_all     cov_all ]')
        disp('--------------------------------------------------------------------------------')
        disp([ rpm_all , icam_all , ecam_all , torque_all , apc_all , cov_all ])
    
        % 기존의 그림에 위에서 마우스로 클릭한 점에 marker를 표시한다.
        subplot(2,2,1)
        plot( icam_now , ecam_now , 'wo' ); % 흰색 동그라미 마커
        subplot(2,2,2)
        plot( icam_now , ecam_now , 'wo' ); % 흰색 동그라미 마커
        subplot(2,2,3)
        plot( icam_now , ecam_now , 'wo' ); % 흰색 동그라미 마커

    end
    
end

format % format short g 에서 다시 format으로 원상 복귀
hold off