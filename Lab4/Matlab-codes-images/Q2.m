clear;
close all;

I = imread('handBW.pnm'); % Read the image
figure(2);imshow(I); % Show the image
figure(3);imhist(I); % Show the histogram


figure(4);mtresh(I,100,175);






