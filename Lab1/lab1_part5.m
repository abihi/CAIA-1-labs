clear;

I = imread('images/zebra.png');
%I = imread('images/cameraman.png');

Jnf = imresize(I, [78 78], 'nearest', 'antialiasing', false);
Jnt = imresize(I, [78 78], 'nearest', 'antialiasing', true);
Jbf = imresize(I, [78 78], 'bilinear', 'antialiasing', false);
Jbt = imresize(I, [78 78], 'bilinear', 'antialiasing', true);
figure
imshow(I)
figure
ax1 = subplot(2,2,1);
imshow(Jnf)
ax2 = subplot(2,2,2);
imshow(Jnt)
ax3 = subplot(2,2,3);
imshow(Jbf)
ax4 = subplot(2,2,4);
imshow(Jbt)