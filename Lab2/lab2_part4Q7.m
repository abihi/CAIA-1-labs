clear;
close all;
I = imread('images/wagon_shot_noise.png');

avg = fspecial('average', [7 7]);
meanFilter   = imfilter(I, avg, 'replicate');
gaussFilter  = imgaussfilt(I, 2);
medianFilter = medfilt2(I);

figure
colormap(gray)
ax1 = subplot(3,1,1);
imagesc([I, meanFilter])
ax2 = subplot(3,1,2);
imagesc([I, gaussFilter])
ax3 = subplot(3,1,3);
imagesc([I, medianFilter])