clear;
close all;

I = double(imread('images/cameraman.png'));

I_freq  = fft2(I);
I_shift = fftshift(I_freq);
I_abs   = abs(I_shift);
I_log   = log(I_abs);
minValue = min(min(I_log));
maxValue = max(max(I_log));

figure
ax1 = subplot(1,2,1);
imshow(uint8(I))
ax2 = subplot(1,2,2);
imshow(I_log, [minValue maxValue])
