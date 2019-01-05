clear;

I = imread('images/wrench.png');

J = imrotate(I,20);
K = imrotate(I,20,'bilinear');

%speed test
disp("Rotation arbitrary degree");
tic;
arbitrary  = imrotate(I, 182);
toc;
disp("Rotation multiple 90");
tic;
multiple90 = imrotate(I, 180);
toc;

ax1 = subplot(2,2,1);
imshow(J)
ax2 = subplot(2,2,2);
imshow(K)
ax3 = subplot(2,2,3);
imshow(I)