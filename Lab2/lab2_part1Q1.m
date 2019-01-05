clear;
%Examine at least 3 different filter kernels, among which there should be at least 
%one sharpening and one smoothing filter in sizes 3 × 3, 7 × 7 and 31 × 31.  
I = imread('images/cameraman.png');

%Create kernels
h_laplacian_3x3 = fspecial('laplacian');
h_average_31x31 = fspecial('average', 31);
h_log_7x7 = fspecial('log', 7);

%Filter images
laplacian3x3 = imfilter(I,h_laplacian_3x3,'replicate');
blur31x31    = imfilter(I,h_average_31x31,'replicate');
log7x7       = imfilter(I,h_log_7x7,'replicate');
gaussianBlur = imgaussfilt(I, 5);

%Plot images
figure
ax1 = subplot(2,2,1);
imshow(laplacian3x3)
ax2 = subplot(2,2,2);
imshow(log7x7)
ax3 = subplot(2,2,3);
imshow(blur31x31)
ax4 = subplot(2,2,4);
imshow(gaussianBlur)
