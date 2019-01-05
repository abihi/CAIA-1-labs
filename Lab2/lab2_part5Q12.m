clear;
close all;

v = rand(1,6);
even_fft = fftshift(fft2(v));
odd_fft  = fftshift(fft2(rand(1,5)));

disp(v);
%even_real = log(abs(even_fft));
%odd_real  = log(abs(odd_fft));

%disp(odd_fft);
odd_fft(1) = 0;
odd_fft(5) = 0;

disp(even_fft);
even_fft(2) = 0;
even_fft(6) = 0;

odd  = ifft2(ifftshift(odd_fft));
even = ifft2(ifftshift(even_fft));

disp(even);
disp(even_fft);
%disp(odd);
%disp(odd_fft);