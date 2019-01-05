function results = myHist(image)
%Lab 1 histogram equalization implementation
[x, y, z] = size(image);
frequencies = histc(reshape(image, 1, x*y*z), 0:255);
cdf = cumsum(frequencies/sum(frequencies)) ;
results = zeros(x,y,z);
for i = 1:x
    for j = 1:y
        for k = 1:z
            results(i,j,k) = 255 * cdf(double(image(i,j,k)) + 1);
        end
    end
end
%results = 255*cdf(double(image)+1);
results = uint8(results);

end

