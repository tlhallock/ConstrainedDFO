function [s, fail] = algo_update_model(params, s)

% get the shifted set
certification = algo_compute_lagrange(params, ...
    shift_set(s.interpolation_set, s.model_center', s.radius));
fail = ~certification.poised;
if fail
    return;
end
    
% Print lambda
lambda = max(certification.lambdas)
if lambda < params.lambda_max
    s.fully_linear = true;
end

% The new set may be in a different order
s.interpolation_set = unshift_set(certification.shiftedSet, s.model_center', s.radius);

[vals, ~, ds] = mock_structure_get(s.vals, s.interpolation_set);
if max(ds) > 1e-6
    'Did not find a point that was supposed to be in vals'
    throw 1
end


% The coefficients of the model at each basis
s.model_coeff = sum(diag(vals) * certification.lagrange);
% Evaluate the model at a single column vector.
s.model = @(x) sum(s.model_coeff .* params.basis_eval(x'));
% Evaluate the model at several row vectors at once.
s.model_multi = @(x) sum(diag(s.model_coeff) * params.basis_eval(x)')';
% Get the model gradient at the model center
s.g = params.interp_grad_eval(s.model_coeff, zeros(params.dim, 1));


%poisedSet = shuffle_matrix(poisedSet, sort);
test_lagrange(params, s.model_multi, s.model, certification.shiftedSet, s.interpolation_set, vals, s.f);
%test_sort(copyOfOldSet, poisedSet, sort, s.vals);

end