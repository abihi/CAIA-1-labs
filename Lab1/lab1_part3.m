clear;
I = imread('images/napoleon.png');
I_dark = imread('images/napoleon_dark.png');
I_light = imread('images/napoleon_light.png');

%Question 4
I_brighter = I+50;
imtool(I_brighter)
%Question 5
[x, y] = size(I);
I_lower_cont = I.*0.5;
I_lower_contrast = uint8(zeros(x,y));
for i = 1:x
    for j = 1:y
        if(I(i,j) > 128)
           I_lower_contrast(i,j) = I(i,j)-25; 
        else
           I_lower_contrast(i,j) = I(i,j)+25;
        end
    end
end
imtool(I_lower_cont)

%imtool(Is/255)

%imtool(I_dark)
%imtool(I_light)

%Question 3
Is = single(I);
figure
imagesc((I/64)*64)
colorbar
figure
imagesc((Is/64)*64)
colorbar

