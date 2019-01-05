clear;
I_brain1 = imread('images/brain1.png');
I_test   = imread('images/brain1.png');
I_brain2 = imread('images/brain2.png');
I_brain3 = imread('images/brain3.png');

[x, y] = size(I_brain1);
I_mean = zeros(x,y);
%I_test = single(I_test);
for i = 1:x
    for j = 1:y
        I_mean(i,j) = (I_brain1(i,j) + I_brain2(i,j))/2;
        I_test(i,j) = (I_mean(i,j) + 100.0);
    end
end
I_mean = uint8(I_mean);
I_diff = imsubtract(I_mean, I_brain3);

ax1 = subplot(2,2,1);
imshow(I_mean)
ax2 = subplot(2,2,2);
imshow(I_brain3)
ax3 = subplot(2,2,3);
imshow(I_diff)
ax4 = subplot(2,2,4);
imshow(I_test)
