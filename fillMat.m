function [retVal] = fillMat(mat, desiredNumRows)
retVal = [mat; repmat(mat(1,:), desiredNumRows - size(mat, 1), 1)];
end
