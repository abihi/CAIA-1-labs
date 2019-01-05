clear;
I = imread('images/peppers.png');
I_gray = rgb2gray(I);

image = I; 
%default is 64 bins for histeq
J = histeq(image,256);
K = myHist(image);

figure
ax1 = subplot(2,3,1);
imshow(image)
ax2 = subplot(2,3,2);
imshow(J)
ax3 = subplot(2,3,3);
imshow(K)
ax4 = subplot(2,3,4);
imhist(image);
ax5 = subplot(2,3,5);
imhist(J);
ax6 = subplot(2,3,6);
imhist(K);