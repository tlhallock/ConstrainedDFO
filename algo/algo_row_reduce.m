function [shiftedSet, sort, lagrange, lambdas, poised] = algo_row_reduce(params, shiftedSet, improve)

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

numReplaced = 0;

certified = false;
while ~certified
    % find lagrange polynomials
    V(1:npoints, :)      = params.basis_eval(shiftedSet);
    V((npoints + 1):h,:) = eye(p, p);
    
    testV(params, V, shiftedSet);
    
    for i=1:p
        [maxVal, maxRow] = max(abs(V(i:npoints,i)));
        if maxVal < params.xsi
            if ~improve
                % Set not poised...
                shiftedSet = [];
                sort = [];
                lagrange = [];
                lambdas = [];
                poised = false;
                return;
            end
            
            % if not poised, have to replace this point
            extrema = params.interp_extrema(V((npoints+1):h, i));
            V(i, :) = params.basis_eval(extrema.maxX') * V((npoints+1):h, :);
            shiftedSet(i, :) = extrema.maxX';
            
            if sort(i) > 0
                numReplaced = numReplaced + 1;
            end
            sort(i) = -abs(sort(i));
            [~, maxRow] = max(abs(V(i:npoints,i)));
            
            testV(params, V, shiftedSet);
            
            % Could check extrema.maxVal to make sure it is big enough...
        end
        
        if maxRow ~= 1
            maxRow = maxRow + i - 1;
            
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
    
    worstLambdaIdx = -1;
    worstLambdaVal = -1;
    worstLambdaRpl = [];
    
    certified = true;
    
    % find the worst lambda
    for i = 1:npoints
        extrema = params.interp_extrema(lagrange(i , :));
        lambdas(i) = extrema.maxVal;
        if lambdas(i) > worstLambdaVal
            worstLambdaIdx = i;
            worstLambdaVal = lambdas(i);
            worstLambdaRpl = extrema.maxX;
        end
    end
    
    if worstLambdaVal > params.lambda_max && improve
        shiftedSet(worstLambdaIdx, :) = worstLambdaRpl';
        certified = false;
        if sort(worstLambdaIdx) > 0
            numReplaced = numReplaced + 1;
        end
        sort(worstLambdaIdx) = -abs(sort(worstLambdaIdx));
    end
end

end
