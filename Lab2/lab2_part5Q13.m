clear;
close all;

I = double(imread('images/cameraman.png'));

[x,y] = size(I);
F = fftshift(fft2(I));

%cutoff frequency distance
d0 = 15;
%offset so the filter starts at DC-component
offset = ~mod(size(I),2) + 1;
filter = zeros(x,y);
for i=1:x
    for j=1:y
        % Ideal low pass filter circle
        %if sqrt((i-(x+2)/offset(1))^2+(j-(y+2)/offset(2))^2) <= d0
        %    filter(i,j) = 1;
        %end
        
        %Butterworth low pass filter (swap D/d0 for high pass)
        n = 2;
        D = sqrt((i-(x+2)/2)^2+(j-(y+2)/2)^2);
        filter(i,j) = (1+(D/d0)^(2*n))^(-1);
    end
end

%apply filter
F = F .* filter;

%square size
square = [90 90];
%create square that keeps symmetry
%F(1:square(2)+offset(2), :) = 0;
%F(:, 1:square(1)+offset(1)) = 0;
%F(end-(0:square(2)),:) = 0;
%F(:, end-(0:square(1))) = 0;

iF = ifft2(ifftshift(F));

figure
ax1 = subplot(1,3,1);
imshow(uint8(I))
ax2 = subplot(1,3,2);
imshow(uint8(iF))
ax3 = subplot(1,3,3);
%Visualize spectrum
F_log = log(abs(F));
minValue = min(min(F_log));
maxValue = max(max(F_log));
imshow(F_log, [minValue maxValue])