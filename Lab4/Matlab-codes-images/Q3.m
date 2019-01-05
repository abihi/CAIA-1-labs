clear;
close all;

I2 = imread('hand.pnm'); % Read the image
figure(5);imshow(I2); % Show the image
R = I2(:,:,1); % Separate the three layers, RGB
G = I2(:,:,2);
B = I2(:,:,3);
figure(6);plot3(R(:),G(:),B(:),'.') % 3D scatterplot of the RGB data

label_im = imread('hand_training.png'); % Read image with labels
figure(7);imagesc(label_im); % View the training areas

I3(:,:,1) = R; % Create an image with two bands/features
I3(:,:,2) = B;
[data,class] = create_training_data(I3,label_im); % Arrange the training data into vectors
figure(8);scatterplot2D(data,class); % View the training feature vectors

Itest = im2testdata(I3); % Reshape the image before classification
C = classify(double(Itest),double(data),double(class)); % Train classifier and classify the data
ImC = class2im(C,size(I3,1),size(I3,2)); % Reshape the classification to an image
figure(9);imagesc(ImC); % View the classification result


