clear;
close all;

%estimates: 4x 10kr, 5x 5kr, 17x 1kr, 13x 0.5kr
I = imread('coins.tif');

%Create average fitler
h = fspecial('average');
%Blur the image
I = imfilter(I, h, 'replicate');

%Find suitable threshold value
T = graythresh(I);
%BW = I > T*255;
BW = imbinarize(I, T);
%Fill the holes in each black circle, by majority of nbr values
BW = bwmorph(BW, 'majority');

%Labeling of a binary image. Neighborhood can be 4 or 8 in 2D.
%Used inverse of my binary image otherwise it labeled the background
Ilabel=bwlabel(~BW,4); 
coloredLabels = label2rgb(Ilabel, 'spring');

%Get properties of all objects in the image
objectProps = regionprops(Ilabel, I, 'all');
objectCount = size(objectProps, 1);

%Get area for each object
objectAreas = [objectProps.Area];

%Divide big areas (contains two coins)
for x = 1:length(objectAreas)
    if objectAreas(x) > 4000
       objectAreas(x) = objectAreas(x)/2;
       objectAreas(end+1) = objectAreas(x)/2;
    end
    if objectAreas(x) > 3000
       objectAreas(x) = objectAreas(x)/3;
       objectAreas(end+1) = (objectAreas(x)/3)*2;
    end
end

%Remove areas less than 600
for x = length(objectAreas):-1:1
    if objectAreas(x) < 600
       objectAreas(x) = []; 
    end 
end

%Get count for no. unique area values
uniqueAreas = length(unique(objectAreas));
[count, area] = hist(objectAreas, uniqueAreas/2);

figure;
ax1 = subplot(1,2,1);
%plot histogram
histogram(objectAreas, uint8(uniqueAreas/2));
text(700,  3.5,'5x0.5 kr')
text(980,  3.5,'4x10 kr')
text(1180,  6.5,'11xUnidentified')
text(1500, 4.5,'8x0.5 kr (new)')
text(2000, 6.5,'15x1 kr')
text(2400,  2.5,'4x5 kr')
ax2 = subplot(1,2,2);
%plot segmented image
imshow(coloredLabels);




