function [shiftedSet, sort, lagrange, lambdas, poised] = algo_certify(params, shiftedSet)

poised = true;
npoints = size(shiftedSet, 1);
sort = (1:npoints)';
lambdas = zeros(npoints, 1);

if npoints ~= params.basis_dimension
    'not the right number of points'
    size(s.shiftedSet, 1)
    params.basis_dimension
end

p = params.basis_dimension;
h = npoints + p;
V = zeros(h, p);

certified = false;
while ~certified
    % find lagrange polynomials
    V(1:npoints, :)      = params.basis_eval(shiftedSet);
    V((npoints + 1):h,:) = eye(p, p);
    
    testV(params, V, shiftedSet);
    
    for i=1:p
        maxVal = max(abs(V(i:npoints,i)));
        if maxVal < params.xsi
            poised = false;
            
            % if not poised, have to replace this point
            extrema = params.interp_extrema(V((npoints+1):h, i));
            V(i, :) = params.basis_eval(extrema.maxX') * V((npoints+1):h, :);
            shiftedSet(i, :) = extrema.maxX';
            
            sort(i) = -1;
            maxVal = max(abs(V(i:npoints,i)));
            
            testV(params, V, shiftedSet);
        end
        
        tmp = find(abs(V(i:npoints, i)) == maxVal);
        maxRow = i-1 + tmp(1);
        if maxRow ~= i
            V          = swapRows(V, maxRow, i);
            shiftedSet = swapRows(shiftedSet, maxRow, i);
            sort       = swapRows(sort, maxRow, i);
            
            testV(params, V, shiftedSet);
        end
        
        V(:,i) = V(:,i) / V(i,i);
        testV(params, V, shiftedSet);
        
        for j=1:p
            if i == j
                continue
            end
            V(:,j) = V(:,j) - V(i, j)*V(:, i);
        end
        testV(params, V, shiftedSet);
    end
    
    lagrange = V ((npoints+1):h,:)';
    
    certified = true;
    for i = 1:npoints
        extrema = params.interp_extrema(lagrange(i , :));
        lambdas(i) = extrema.maxVal;
        if lambdas(i) > params.lambda_max
            shiftedSet(i, :) = extrema.maxX';
            certified = false;
        end
    end
end

end
