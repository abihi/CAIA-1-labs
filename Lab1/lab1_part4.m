clear;
I = imread('images/napoleon.png');
%Question 6
%g = 2;
%imhist(I);
%L = double(I).^g;
%out = uint8(L .* (255/max(max(L))));
%imhist(out);
%imtool(out)

%Question 7
figure
imhist(I);
imtool(I);
J = histeq(I);
figure
imhist(J);
imtool(J);