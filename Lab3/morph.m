clear;
close all;

I = imread('coins.tif');

[pixelCount, grayLevels] = imhist(I);
%figure;
%bar(pixelCount);
%title('Histogram of coins.tif');
%xlim([0 grayLevels(end)]); % Scale x axis manually.
%grid on;

%Find suitable threshold value
T = graythresh(I);
%BW = I > T*255;
BW = imbinarize(I, T);
%Fill the holes in each black circle
BW = bwmorph(BW, 'majority');

%Label each object in the image
Ilabel=bwlabel(~BW,4); 
coloredLabels = label2rgb(Ilabel, 'spring');

%Get properties of all objects in the image
objectProps = regionprops(Ilabel, I, 'all');
objectCount = size(objectProps, 1);

%Get area for each object
objectAreas = [objectProps.Area];



histArea = histc(objectAreas);

histogram(histArea);

imshow(BW);





