function [ shiftedSet, pointReplaced ] = algo_replace_points( certification, replacementFunction, radius)

shiftedSet = certification.shiftedSet;

pointReplaced = false;
for i = 1:length(certification.lambdas)
    extrema = replacementFunction(certification.lagrange(i, :));
    newX = extrema.maxX';
    if norm(newX - certification.shiftedSet(i, :)) / radius < 1e-8
        % This is the same point as before, nothing can be done
        continue
    end
    
    if extrema.maxVal < certification.lambdas(i)
        % It does not improve the current point, ignore it
        continue
    end
    
    pointReplaced = true;
    shiftedSet(i, :) = newX';
end

end

