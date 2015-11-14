function [ relativeDiff ] = get_relative_difference( matrix )

sizeOld = size(matrix, 1);

relativeDiff = zeros(1, size(matrix, 2));
for i = 1:sizeOld
    for j = 1:sizeOld
        relativeDiff = max(relativeDiff, abs(matrix(i,:) - matrix(j,:)));
    end
end

end

