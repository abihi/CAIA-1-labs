clear;
close all;

I2 = imread('hand.pnm'); % Read the image
figure(5);imshow(I2); % Show the image
% Separate the three layers, RGB
R = I2(:,:,1); 
G = I2(:,:,2);
B = I2(:,:,3);
%figure(6);plot3(R(:),G(:),B(:),'.') % 3D scatterplot of the RGB data

label_im = imread('hand_training.png'); % Read image with labels
figure(7);imagesc(label_im); % View the training areas

% Create an grayscale image
I3 = rgb2gray(I2);

[data,class] = create_training_data(I3,label_im); % Arrange the training data into vectors
%figure(8);scatterplot2D(data,class); % View the training feature vectors

Itest = im2testdata(I3); % Reshape the image before classification
C = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
ImC = class2im(C,size(I3,1), size(I3,2)); % Reshape the classification to an image
figure(9);imagesc(ImC); % View the classification result

% Create an image with two bands/features
I3(:,:,1) = R; 
I3(:,:,2) = B;

[data,class] = create_training_data(I3,label_im); % Arrange the training data into vectors
figure(10);scatterplot2D(data,class); % View the training feature vectors

Itest = im2testdata(I3); % Reshape the image before classification
C = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
ImC = class2im(C,size(I3,1),size(I3,2)); % Reshape the classification to an image
figure(11);imagesc(ImC); % View the classification result

% Create an image with full RGB
I3(:,:,1) = R; 
I3(:,:,2) = G;
I3(:,:,3) = B;

[data,class] = create_training_data(I3,label_im); % Arrange the training data into vectors
%figure(12);scatterplot2D(data,class); % View the training feature vectors

Itest = im2testdata(I3); % Reshape the image before classification
C = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
ImC = class2im(C,size(I3,1),size(I3,2)); % Reshape the classification to an image
figure(13);imagesc(ImC); % View the classification result


