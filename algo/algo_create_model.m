function [s, results, improve] = algo_create_model(params, s, results, improve)

% find the best set for interpolation
poisedSet = algo_get_interpolation_set(params, s);
% Only works in Octave:
%  shiftedSet = (poisedSet - model_center') / s.radius;

% get the shifted set
shiftedSet = zeros(size(poisedSet));
for i=1:size(poisedSet, 1)
   shiftedSet(i, :) = (poisedSet(i, :) - s.model_center') / s.radius; 
end

% This shouhld be refactored into two separate methods: check poised +
% model improvement
[improvedSet, sort, lagrange, lambdas, poised] = algo_certify(params, shiftedSet, improve);
if ~poised
    improve = true;
    [improvedSet, sort, lagrange, lambdas] = algo_certify(params, shiftedSet, true);
end

% shift them back
for i=1:size(poisedSet, 1)
    poisedSet(i, :) = improvedSet(i, :) * s.radius + s.model_center';
end
    
% Print lambda
lambda = max(lambdas)
% and raw the new poised set
%    scatter(poisedSet(:,1)', poisedSet(:, 2)');
    
% Evaluate the objective at these points as well
for i = 1:length(sort)
    if sort(i) < 1
        x = poisedSet(i, :);
        s.vals = mock_structure_add(s.vals, x, s.f(x'));
        results.fvals = results.fvals + 1;
    end
end

vals = mock_structure_get(s.vals, poisedSet);
% The coefficients of the model at each basis
s.model_coeff = sum(diag(vals) * lagrange);
% Evaluate the model at a single column vector.
s.model = @(x) sum(s.model_coeff .* params.basis_eval(x'));
% Evaluate the model at several row vectors at once.
s.model_multi = @(x) sum(diag(s.model_coeff) * params.basis_eval(x)')';

s.g = params.interp_grad_eval(s.model_coeff, s.model_center);


% This is for plotting purposes...
s.interpolation_set = poisedSet;

test_lagrange(params, s.model_multi, s.model, improvedSet, poisedSet, vals, s.f);

end