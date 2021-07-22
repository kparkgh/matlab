a = 100000*rand(1,2);
a = floor(a);
B = mod(a,10)+1;

B

if ( B(1) == B(2) )
    disp('Congratulations! You have DDANG!')
    load gong; sound(y(1:10000),Fs)
elseif ( (B(1)==3)&(B(2)==8) | (B(1)==8)&(B(2)==3) )
    disp('Congratulations! You have 3-8 ±§∂Ø!')
    load handel; sound(y,Fs)
elseif ( B(1)+B(2) == 10 )
    if ( B(1) ~= 4 & B(1) ~= 6 )
        disp('∏¡≈Î!!')
        load laughter; sound(y(1:10000),Fs)
    end
end
