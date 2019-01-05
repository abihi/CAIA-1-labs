function result = magnitude(I)
%MAGNITUDE of complex numbers in image
%   For a complex value z, |z| is defined as sqrt( (a+bi)*(a-bi) )

[x,y] = size(I);
result = zeros(x,y);

for i = 1:x
    for j = 1:y
        %result(i,j) = sqrt(real(I(i,j))^2 + imag(I(i,j)^2));
        result(i,j) = sqrt(I(i,j) * conj(I(i,j)));
    end
end

end

