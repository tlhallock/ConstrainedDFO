function [mat] = swapRows(mat, idx1, idx2)
    if idx1 == idx2 || idx1 < 1 || idx2 < 1
        return;
    end
    row1 = mat(idx1,:);
    row2 = mat(idx2,:);
    mat(idx1,:) = row2;
    mat(idx2,:) = row1;
end
