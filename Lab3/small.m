clear;
close all;

I = imread('coins.tif');

%Creates a threshold T between 0-1
T = graythresh(I);

%Create binary image, with threshold T
BW = imbinarize(I, T);

BW = bwmorph(BW, 'remove');

BW = bwmorph(BW, 'skel', inf);

%BW = bwmorph(~BW, 'branchpoints');

Ilabel=bwlabel(~BW,4); 
coloredLabels = label2rgb(Ilabel, 'spring');

%Get properties of all objects in the image
objectProps = regionprops(Ilabel, I, 'all');
objectCount = size(objectProps, 1);

imshow(coloredLabels);


