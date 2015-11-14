function [ extrema ] = algo_replace_subset(f, possibleX)

extrema = struct();

extrema.maxX = -1;
extrema.minX = -1;
extrema.minVal =  1e300;
extrema.maxVal = -1e300;


vals = f(possibleX);

[minX, minVal] = min(vals);
vals = abs(vals);
[maxX, maxVal] = max(vals);

extrema.minX = minX;
extrema.maxX = maxX;
extrema.minVal = minVal;
extrema.maxVal = maxVal;

end

