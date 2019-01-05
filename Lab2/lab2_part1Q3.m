clc;
clear;
close all;
I = imread('images/cameraman.png');

%low pass filtering using high-pass filter
%h_laplacian_filter = fspecial('laplacian');
%sharpened_image    = imfilter(I,h_laplacian_filter,'replicate');
%I_low_pass         = I + sharpened_image;
I_low_pass         = imgaussfilt(I, 5);

%high pass filtering using low-pass filter
h_disk_filter = fspecial('disk', 2);
disk_image    = imfilter(I, h_disk_filter, 'replicate');
I_high_pass   = I - disk_image;

%difference of gaussians band-pass filter
gaussian_high_std = imgaussfilt(I, 5);
gaussian_low_std  = imgaussfilt(I, 0.5);
I_DoG = I - (gaussian_low_std - gaussian_high_std);

figure
ax1 = subplot(1,3,1);
imshow(I_low_pass)
ax2 = subplot(1,3,2);
imshow(I_high_pass)
ax3 = subplot(1,3,3);
imshow(I_DoG)