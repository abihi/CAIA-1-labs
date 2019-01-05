clear;
close all;
I_original = imread('images/wagon_shot_noise.png');
I = I_original;

[x, y, ~] = size(I);
for i = 2:x-1
    for j = 2:y-1
        v = [I(i-1,j+1), I(i,j+1), I(i+1,j+1), I(i-1,j), ...
            I(i,j) I(i+1,j), I(i-1,j-1), I(i,j-1), I(i+1,j-1)];
        I(i,j) = median(v);
    end
end

figure
colormap(gray);
imagesc([I_original, I])
