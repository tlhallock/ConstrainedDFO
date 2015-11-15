function [certification] = algo_compute_lagrange(params, initialSet, replacementFunction)

% params
%   includes the method of evaluating basis functions at given points
% shiftedSet
%   is the initial set of points to check poisedness
% replacement
%   function is provides extrema for the basis function


certification = struct();
% At the end, certification will include:
% shiftedSet
%   A new shifted set that with rows permuted, and possibly points replaced
%   if improve is true
% lagrange
%   The set of lagrange polynomials for the new set of points
% lambdas
%   The maximum value of any lagrange polynomial over the unit ball
% lambdaXs
%   The x-value that produces the maximum value computed in lambda
% poised
%   A flag that signifies of the computation was successful.
%   If improve is false, and the set is not poised for interpolation, then
%   poised is false, and all other elements of this struct are meaningless.



% sort
%   A permuation vector of the rows that were permuted, negative values
%   were replaced

improve = nargin > 2;

certification.poised = true;
certification.shiftedSet = initialSet;
npoints = size(certification.shiftedSet, 1);

if npoints ~= params.basis_dimension
    'not the right number of points'
    size(s.shiftedSet, 1)
    params.basis_dimension
end

p = params.basis_dimension;
h = npoints + p;
V = zeros(h, p);

V(1:npoints, :)      = params.basis_eval(certification.shiftedSet);
V((npoints + 1):h,:) = eye(p, p);

testV(params, V, certification.shiftedSet);

for i=1:p
    [maxVal, maxRow] = max(abs(V(i:npoints,i)));
    if maxVal < params.xsi
        if improve
            % If not poised, have to replace this point
            extrema = replacementFunction(V((npoints+1):h, i));
            V(i, :) = params.basis_eval(extrema.maxX') * V((npoints+1):h, :);
            certification.shiftedSet(i, :) = extrema.maxX';
            [maxVal, maxRow] = max(abs(V(i:npoints,i)));
            
            testV(params, V, certification.shiftedSet);
        end
        if maxVal < params.xsi
            % Still not poised, failure is the only option.
            certification.shiftedSet = [];
            certification.lagrange = [];
            certification.lambdas = [];
            certification.lambdaXs = [];
            certification.poised = false;
            return;
        end
    end
    
    if maxRow ~= 1
        maxRow = maxRow + i - 1;
        
        V = swapRows(V, maxRow, i);
        certification.shiftedSet = swapRows(certification.shiftedSet, maxRow, i);
        
        testV(params, V, certification.shiftedSet);
    end
    
    V(:,i) = V(:,i) / V(i,i);
    testV(params, V, certification.shiftedSet);
    
    for j=1:p
        if i == j
            continue
        end
        V(:,j) = V(:,j) - V(i, j)*V(:, i);
    end
    testV(params, V, certification.shiftedSet);
end

certification.lagrange = V ((npoints+1):h,:)';
certification.lambdas = zeros(npoints, 1);
certification.lambdaXs = zeros(npoints, size(certification.shiftedSet, 2));

for i = 1:npoints
    extrema = params.interp_extrema(certification.lagrange(i , :));
    certification.lambdas(i) = extrema.maxVal;
    certification.lambdaXs(i, :) = extrema.maxX';
end

end
