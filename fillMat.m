function [retVal] = fillMat(mat, desiredNumRows)

if size(mat, 1) <= desiredNumRows
    % Make it atleast as big as the desired number...
    retVal = [mat; repmat(mat(1,:), desiredNumRows - size(mat, 1), 1)];
else
    % Make it no bigger than the desired number...
    retVal = mat(1:desiredNumRows, :);
end

end
