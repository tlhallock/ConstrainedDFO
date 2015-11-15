function [ extrema ] = algo_computed_extrema(vals, possibleX)

extrema = struct();

extrema.maxX = -1;
extrema.minX = -1;
extrema.minVal =  1e300;
extrema.maxVal = -1e300;

[minVal, minIdx] = min(vals);
vals = abs(vals);
[maxVal, maxIdx] = max(vals);

extrema.minX = possibleX(minIdx, :)';
extrema.maxX = possibleX(maxIdx, :)';
extrema.minVal = minVal;
extrema.maxVal = maxVal;

end

