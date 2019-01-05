clear;
close all;

I = imread('bacteria.tif');

%Creates a threshold T between 0-1
T = graythresh(I);

%Create binary image, with threshold T
bw = imbinarize(I, T);

%Fill the holes in each black circle, 'majority' sets a pixel 
%to 1 if five or more pixels in its 3-by-3 neighborhood are 1's, else to 0
bw2 = bwmorph(bw, 'majority');

%Distance transform, hills changed to valleys
D = -bwdist(bw2);
%imshow(D,[])

%watershed on distance transform
Ld = watershed(D);
%imshow(label2rgb(Ld))

%Add watershed lines to original image
bw2 = bw;
bw2(Ld == 0) = 1;
%imshow(bw2)

%Labeling of a binary image. Neighborhood can be 4 or 8 in 2D.
%Used inverse of my binary image otherwise it labeled the background
Ilabel=bwlabel(~bw2,8); 
coloredLabels = label2rgb(Ilabel, 'spring');
%imshow(coloredLabels);

%Get properties of all objects in the image
objectProps = regionprops(Ilabel, 'all');
objectCount = size(objectProps, 1);

%Get radius for each object and centers for plotting
objectRadii = zeros(1, objectCount);
objectCenters = zeros(objectCount,2);
%Get centers of each object, returns 1x(objectCount * 2) length
centersUnformated = [objectProps.Centroid];
%Length in pixels for major/minor axis of each object
majorAxisLen = [objectProps.MajorAxisLength];
minorAxisLen = [objectProps.MinorAxisLength];
centerI = 1;
for i=1:objectCount
    %Calculate radius for each object
    objectRadii(i) = (mean([majorAxisLen(i) minorAxisLen(i)],2))/2;
    %Put center values in the right format (x,y)
    objectCenters(i,1) = centersUnformated(centerI); 
    objectCenters(i,2) = centersUnformated(centerI+1);
    centerI = centerI + 2;
end

%save copy for plot
plotRadii = objectRadii;

%Remove the 2 small oversegmentation artifacts 
objectRadii(objectRadii < 10) = [];

%Get count for no. unique area values
uniqueRadii = length(unique(objectRadii));

figure;
ax1 = subplot(1,3,1);
%plot histogram
histogram(objectRadii, uint8(uniqueRadii/2));
text(17,  2.5,'5x0.5 kr')
text(19,  4.5,'7x10 kr')
text(12.4,  1.5,'1xUnidentified')
text(20, 7.5,'10x0.5 kr (new)')
text(23.6, 11.5,'20x1 kr')
text(27,  4.5,'5x5 kr')
ax2 = subplot(1,3,2);
%plot segmented image
imshow(coloredLabels);
viscircles(objectCenters,plotRadii);
ax3 = subplot(1,3,3);
%plot original image
imshow(I);


