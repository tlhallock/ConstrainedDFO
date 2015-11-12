function [mat] = swapRows(mat, idx1, idx2)
    row1 = mat(idx1,:);
    row2 = mat(idx2,:);
    mat(idx1,:) = row2;
    mat(idx2,:) = row1;
end
