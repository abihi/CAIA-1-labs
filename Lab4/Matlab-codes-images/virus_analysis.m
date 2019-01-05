clear;
close all;
%% Read image and template from disk

% Read image
I = imread('viruses.tif');

% Read template
template = imread('virusTemplate.tif');

% Show image and template
figure('name','Original image');imshow(I);
figure('name','Template');imshow(template);

%% Template matching

% Select step length (How many pixels the template is moved in each
% iteration)
stepSize = 10;

% Do the template matching
ccimg = templatematching(I,template,stepSize);

% Show the resulting correlation image
%figure('name','correlation coefficients');imshow(ccimg,[]);colormap(copper);colorbar;


%% Find localmaxima in the correlation image

maxima = imextendedmax(ccimg,0,4);

% Shrink objects to points
maxima = bwmorph(maxima,'shrink',inf);

% Calculate the correlation coefficients for the maxima
maxvals = maxima .* ccimg;

% Pick the corresponding correlation values and threshold them sung Otsu's
% method.
h = hist(maxvals(maxvals > 0),128);
h2 = imfilter(h,[1 1 1 1 1] ./ 5);
thresh = graythresh(h2);

% Create a binary image keeping only those with a correlation value that 
% lies above the threshold.
maxvals(maxvals < thresh) = 0;
maxvals(maxvals ~= 0) = 1;

% Label the binary image and obtain their positions
maxlbl = logical(maxvals);
maxcentroids = regionprops(maxlbl,'centroid');

% Create a circular mask which will be used to cutout individual objects
% from the original image.
[h,w] = size(template);
d = max([h w]);
mask = imcircle(d);

% Cut out all objects using the mask and store it in a cell array 
% named "cutouts".
nrOfObjects = length(maxcentroids);
cutouts{nrOfObjects} = [];
figure('name','Segmentation result');imshow(I);hold on;
for i = 1 : nrOfObjects
    % The position corresponding to the centroid has to be calculated since
    % the centroid position depends on the step size (stepSize) used.
    realpos = [((maxcentroids(i).Centroid(1)-1)*stepSize+1) ((maxcentroids(i).Centroid(2)-1)*stepSize+1)];
    
    cutouts{i} = I(realpos(2):realpos(2)+d-1,realpos(1):realpos(1)+d-1);
    cutouts{i} = cutouts{i} .* uint8(mask);
    
    
    rectangle('Position',[realpos(1),realpos(2),d,d],...
        'Curvature',[1,1],...
        'edgecolor', 'w',...
        'linewidth', 1 );
end
hold off;

%% Adding one noisy disk and one gray disk

refimg = noise(100 .* ones(size(mask)),'mu',1);
cutouts{1,end+1} = uint8(refimg.* mask);
cutouts{1,end+1} = uint8(mask).*128;

%% Collect all cutouts in an image

imagesPerRow = 10;
cols = imagesPerRow;
rows = ceil(size(cutouts,2) / cols);

objectMap = uint8(zeros(size(mask).*[rows cols]));
counter = 1;

for i = 1 : rows
    for j = 1 : cols
        if counter <= size(cutouts,2)
            objectMap((i-1)*d+1:(i-1)*d+d,(j-1)*d+1:(j-1)*d+d) = cutouts{counter}(:,:);
            counter = counter + 1;
        end
    end    
end

figure('name','Cutouts of segmented objects');imshow(objectMap);

%% cleaning the workspace from surplus variables 
keep('I','template','mask','cutouts','nrOfObjects');%'objectMap');

%% Texture analysis
% 
% I             - original image
% template      - the template used in the template matching procedure
% cutouts       - a cell array with all the segmented objects
% nrOfObjects   - the number of objects in 'cutouts'
% mask          - the binary mask used to cutout the objects
% objectMap     - a compiled image of all the objects in 'cutouts'
%

% Place for your own texture analysis. 
% Get the co-occurrence matrices for a few examples
[C1,I1] = graycomatrix(cutouts{42},'Offset',[6 9],'Symmetric', true);
[C2,I2] = graycomatrix(cutouts{43},'Offset',[6 9],'Symmetric', true);
[C3,I3] = graycomatrix(cutouts{12},'Offset',[6 9],'Symmetric', true);
[C4,I4] = graycomatrix(cutouts{37},'Offset',[6 9],'Symmetric', true);

% Plot these results
figure;
% Noisy Image
subplot(4,2,1); imshow(cutouts{42}); title('Noisy');
subplot(4,2,2); image(C1); title('Noisy Co-occurrence Matrix');
% Constant Image
subplot(4,2,3); imshow(cutouts{43}); title('Constant Color');
subplot(4,2,4); image(C2); title('Constant Color Co-occurrence Matrix');
% Correct Image
subplot(4,2,5); imshow(cutouts{12}); title('Correct');
subplot(4,2,6); image(C3); title('Correct Co-occurrence Matrix');
% Incorrect Image
subplot(4,2,7); imshow(cutouts{37}); title('Incorrect');
subplot(4,2,8); image(C4); title('Incorrect Co-occurrence Matrix');


% Loop through all objects and get their entropy and uniformity
E = zeros(41,1);
U = zeros(41,1);
for i = 1:nrOfObjects
    C = graycomatrix(cutouts{i},'Offset',[6 9],'Symmetric', true);
    E(i,1) = entropy(cutouts{i});
    U_temp = graycoprops(C,{'energy'});
    U(i,1) = U_temp.Energy;
end

figure;
plot(E,U,'o');
xlabel('Entropy')
ylabel('Uniformity')
title('Entropy vs Uniformity for Virus Detections')


% Create new set based on entropy and uniformity
[h,w] = size(template);
d = max([h w]);


imagesPerRow = 10;
cols = imagesPerRow;
rows = ceil(size(cutouts,2) / cols);
newObjectMap = uint8(zeros(size(mask).*[rows cols]));

counter = 1;
for i = 1 : rows
    for j = 1 : cols
        if counter <= size(cutouts,2) && counter <= size(E,1)
            if U(counter,1) < 0.1 && E(counter,1) > 6
                newObjectMap((i-1)*d+1:(i-1)*d+d,(j-1)*d+1:(j-1)*d+d) = cutouts{counter}(:,:);
            end
            counter = counter + 1;
        end
    end    
end

figure('name','Cutouts of segmented objects (Corrected)');imshow(newObjectMap);



