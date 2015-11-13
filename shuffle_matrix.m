function [mat] = shuffle_matrix(mat, sort)

for i = 1:size(mat, 1)
    mat = swapRows(mat, i, sort(i));
end

