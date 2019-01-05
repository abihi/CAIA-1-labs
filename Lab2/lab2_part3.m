clear;
close all;
I_wagon = imread('images/wagon.png');
I_camera = imread('images/cameraman.png');

h = fspecial('sobel');

I_wagon_vertical = double(imfilter(I_wagon, h', 'replicate', 'same', 'conv'));
I_wagon_horizontal = double(imfilter(I_wagon, h, 'replicate', 'same', 'conv'));

I_camera_vertical = double(imfilter(I_camera, h', 'replicate', 'same', 'conv'));
I_camera_horizontal = double(imfilter(I_camera, h, 'replicate', 'same', 'conv'));

I_camera_sobel = uint8( (I_camera_vertical.^2 + I_camera_horizontal.^2).^0.5 );
I_wagon_sobel  = uint8( (I_wagon_vertical.^2 + I_wagon_horizontal.^2).^0.5   );

figure
colormap(gray)
ax1 = subplot(2,1,1);
imagesc([I_camera, I_camera_sobel]);
ax2 = subplot(2,1,2);
imagesc([I_wagon, I_wagon_sobel]);