function [ relativeDiff ] = get_relative_difference( matrix )

sizeOld = size(matrix, 1);
dim = size(matrix, 2);

if sizeOld == 1
    relativeDiff = ones(1, dim);
    return;
end

relativeDiff = zeros(1, dim);
for i = 1:sizeOld
    for j = 1:sizeOld
        relativeDiff = max(relativeDiff, abs(matrix(i,:) - matrix(j,:)));
    end
end

if max(relativeDiff) < 1e-15
    relativeDiff = ones(1, dim);
end

