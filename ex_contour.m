% ex_coutour.m

load ex_contour

plot(x1,y1,'o',x2,y2,'+')
axis([15 30 1.4 2.1])
text(x1-0.1,y1-0.03,num2str(n1))
text(x2-0.1,y2+0.03,num2str(n2))
title('Numbers represent z values at each point.')
xlabel('x'), ylabel('y')
legend('condition 1', 'conditio 2')

disp('Note that x and y coordinates for o and + are different !')
disp('x and y points for o are stored in x1 and y1.')
disp('x and y points for + are stored in x2 and y2.')


