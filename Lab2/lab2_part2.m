clear;
close all;
I_camera = imread('images/cameraman.png');
I_wrench = imread('images/wrench.png');

%sharpened = original + alfa · ( original – smoothed )
alfa = 9;
h_average = fspecial('average', 3);
h_disk    = fspecial('disk', 3);
I_camera_smoothed  = imfilter(I_camera, h_average, 'replicate');
I_wrench_smoothed  = imfilter(I_wrench, h_disk, 'replicate');
I_camera_g_smoothed = imgaussfilt(I_camera, 0.5);
I_wrench_g_smoothed = imgaussfilt(I_wrench, 0.5);
I_camera_sharpened = I_camera + alfa * (I_camera - I_camera_g_smoothed);
I_wrench_sharpened = I_wrench + alfa * (I_wrench - I_wrench_g_smoothed);

figure
colormap(gray)
ax1 = subplot(2,1,1);
imagesc([I_camera, I_camera_sharpened]);
ax2 = subplot(2,1,2);
imagesc([I_wrench, I_wrench_sharpened]);


