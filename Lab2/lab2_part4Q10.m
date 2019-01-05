clear;
close all;

I = im2double(imread('images/cameraman.png'));

h = fspecial('gaussian', 9, 4);
out = imfilter(I, h);

figure
colormap(gray)
imshow(out)