function [s] = algo_model_improve(params, s)

[shiftedSet, replacementFunction] = algo_guess_interpolation_set(params, s);

npoints = size(shiftedSet, 1);
if npoints ~= params.basis_dimension
    'not the right number of points'
    size(s.shiftedSet, 1)
    params.basis_dimension
end

iters = 0;
certified = false;
while ~certified
    iters = iters + 1;
    if iters > params.max_improvement_iterations
        'Ran too many iterations of model improvement'
        throw 1
    end
    
    certification = algo_compute_lagrange(params, shiftedSet, replacementFunction);
    if ~certification.poised
        % Set not poised, and not possible to make poised by point replacement
        % Need to replace points within the lagrange computation
        certification = algo_compute_lagrange(params, shiftedSet, @(x) (params.interp_extrema(x)));
    end
        
    % First, try to replace with points that we have already computed
    [ shiftedSet, pointReplaced ] = algo_replace_points(certification, replacementFunction, s.radius);
    if pointReplaced
        % We successfully decreased lambda with a point already computed
        continue
    end
    
    % Check if lambda is now good enough, and find a new point to add if not
    % We have already tried all possible computed points
    
    [maxLambda, maxIndex] = max(certification.lambdas);
    certified = true;
    if maxLambda > params.lambda_max
        shiftedSet(maxIndex, :) = certification.lambdaXs(maxIndex, :);
        certified = false;
    end
end
 
 % should have replace the same number of vectors as negative in sort
% if sum(certification.sort < 0) ~= certification.numReplaced
%     'did not replace the right number of points'
%     numReplaced
%     sum(sort < 0)
%    throw 1
% end


newPoisedSet = unshift_set(shiftedSet, s.model_center', s.radius);
s.plot_number = plot_replacement(s, newPoisedSet);
s.interpolation_set = newPoisedSet;

% Evaluate the objective at these points as well
s.vals = mock_structure_add(s.vals,  s.interpolation_set, s.f, s.radius);

% test that the datastructure is still correct...
test_structure(s);

s.fullyLinear = true;

[s, fail] = algo_update_model(params, s);
if fail
    % If not possible even after improving the model, we have to fail...
    throw 1
end

end
