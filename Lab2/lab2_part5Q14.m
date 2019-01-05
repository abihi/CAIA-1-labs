clear;
close all;

I = double(imread('images/freqdist.png'));

F = fftshift(fft2(I));
[m, n] = size(I);

%notch filter
filter = ones(m,n);
%magnitude of freqs
F_log  = log(abs(F));

%find frequencies to remove
rm   = F_log < 11.6;
%define line length going out from removed points
line = 10;

for i=1:m
    for j=1:n
        if rm(i,j) == 0 && (i ~= 129 && j ~= 129)
            %choose line length
            %filter(i, j-line:j+line) = 0;
            %filter(i-line:i+line, j) = 0;
            %create end to end lines
            filter(i, 1:n) = 0;
            filter(1:m, j) = 0;
        end
    end
end

% apply notch filter
F = F .* filter;

% Fourier inverse
iF = ifft2(ifftshift(F));

%sharpen image using unsharp masking
sharpened = imsharpen(iF,'Radius',2,'Amount',1);

figure
ax1 = subplot(1,2,1);
imshow(uint8(sharpened))
ax2 = subplot(1,2,2);
% Visualize spectrum
F_log    = log(abs(F));
minValue = min(min(F_log));
maxValue = max(max(F_log));
imshow(F_log, [minValue maxValue])