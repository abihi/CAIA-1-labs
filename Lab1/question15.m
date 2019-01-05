clear;
I = imread('images/peppers.png');
I_gray = rgb2gray(I);

resizedOriginal = uint8(aspect_resize(I, 128, 128, 255));
resizedGray = uint8(aspect_resize(I_gray, 128, 128, 255));
averageGray = uint8(average_of_image(resizedGray, 5));
subtractedImage = imsubtract(averageGray, resizedGray);

ax1 = subplot(2,2,1);
imshow(I)
ax2 = subplot(2,2,2);
imshow(resizedGray)
ax3 = subplot(2,2,3);
imshow(averageGray)
ax4 = subplot(2,2,4);
imshow(subtractedImage)
