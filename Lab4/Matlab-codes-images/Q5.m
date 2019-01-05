clear;
close all;

load landsat_data.mat

%Best channels: 4, 5, 6 - All
LS = landsat_data(:,:,[4,5,6]);
%LS = landsat_data(:,:,:);
%figure(1);imshow(LS./255);

% Create an empty image for training areas
T = zeros(512,512);
T(450:500,150:200) = 1;
T(200:230,80:115) = 2;
T(225:245,290:315) = 4;
T(490:500,40:65) = 3;
%figure(3);imagesc(T);

[data,class] = create_training_data(LS,T); % Arrange the training data into vectors
figure(4);scatterplot2D(data,class); % View the training feature vectors

Itest = im2testdata(LS); % Reshape the image before classification
C = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
ImC = class2im(C,size(LS,1),size(LS,2)); % Reshape the classification to an image
figure(5);imagesc(ImC); % View the classification result

