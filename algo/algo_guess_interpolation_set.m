function [shiftedSet, replacementFunction] = algo_guess_interpolation_set(params, s)

if size(s.vals.xs, 1) < 1
    'Have to have atleast one interpolation point.'
    throw 1
end

% Get all points in the outer trust region
possibleCandidates = mock_structure_find_all(s.vals, s.model_center, params.basis_dimension, params.outer_trust_region * s.radius);
test_trust_region(params, s, possibleCandidates);

% Shift them
shiftedCandidates = shift_set(possibleCandidates, s.model_center', s.radius);

% The initial guess (use the closest points)
shiftedSet = fillMat(shiftedCandidates, params.basis_dimension);

% Only replace points with other points in the outer radius...



eval = @(c, x) (sum(diag(c) * params.basis_eval(x)')');
replacementFunction = @(poly) (algo_computed_extrema(eval(poly, shiftedCandidates), shiftedCandidates));


% Try to find the best poised set
iters = 0;
pointReplaced = true; % starting value to enter the loop
while pointReplaced
    iters = iters + 1;
    if iters > params.max_improvement_iterations
        'Tried to improve too many times'
        throw 1
    end
    certification = algo_compute_lagrange(params, shiftedSet, replacementFunction);
    if ~certification.poised
        break;
    end
    
    [ shiftedSet, pointReplaced ] = algo_replace_points(certification, replacementFunction, s.radius);
end

% if npoints ~= params.basis_dimension
%    'not the right number of points'
%    size(s.shiftedSet, 1)
%    params.basis_dimension
% end

end
