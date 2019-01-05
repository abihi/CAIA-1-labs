clear;
close all;
I = imread('images/wagon_shot_noise.png');

medianFilter3x3   = medfilt2(I, [3 3]);
medianFilter7x7   = medfilt2(I, [7 7]);
medianFilter31x31 = medfilt2(I, [31 31]);

figure
ax1 = subplot(2,2,1);
imshow(I)
ax2 = subplot(2,2,2);
imshow(medianFilter3x3)
ax3 = subplot(2,2,3);
imshow(medianFilter7x7)
ax4 = subplot(2,2,4);
imshow(medianFilter31x31)

