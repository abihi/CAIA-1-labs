function results = average_of_image(image, windowSize)
%AVERAGE_OF_IMAGE Summary of this function goes here
%   Detailed explanation goes here
[rowSize, colSize] = size(image);
results = zeros(rowSize, colSize);
for rowInd = 1:rowSize
    for colInd = 1:colSize
        rowWindowStart = rowInd;
        colWindowStart = colInd;
        rowWindowEnd = rowInd + windowSize;
        colWindowEnd = colInd + windowSize;
        if rowInd+windowSize > rowSize
            rowWindowStart = rowWindowStart - abs(rowInd+windowSize - rowSize);
            rowWindowEnd = rowSize;
        end    
        if colInd+windowSize > colSize
            colWindowStart = colWindowStart - abs(colInd+windowSize - colSize);
            colWindowEnd = colSize;
        end
        imgWindow = image(rowWindowStart:rowWindowEnd, colWindowStart:colWindowEnd);
        [rowsWindow, colsWindow] = size(imgWindow);
        s = sum(imgWindow);
        total = sum(s);
        avgOfWindow = total/(rowsWindow*colsWindow);
        results(rowInd, colInd) = avgOfWindow;
    end
end
end

