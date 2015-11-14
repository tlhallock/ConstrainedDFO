function [s, results, improve] = algo_create_model(params, s, results, improve)

% find the best set for interpolation
poisedSet = algo_get_interpolation_set(params, s);


if params.only_in_trust_region
   for i = 1:size(poisedSet, 1)
       if norm(poisedSet(i, :) - s.model_center') > s.radius
           poisedSet(i, :)
           s.model_center'
           poisedSet(i, :) - s.model_center'
           norm(poisedSet(i, :) - s.model_center')
           s.radius
           'Picked points too far away from the model center'
           algo_get_interpolation_set(params, s)
           throw 1
       end
   end
end
    


copyOfOldSet = poisedSet;

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

test_sort(copyOfOldSet, poisedSet, sort, s.vals);
    
% Print lambda
lambda = max(lambdas)
% and raw the new poised set
%    scatter(poisedSet(:,1)', poisedSet(:, 2)');
%plot_replacement(copyOfOldSet, poisedSet, s.vals, sort)
    
% Evaluate the objective at these points as well
for i = 1:length(sort)
    if sort(i) < 0
        x = poisedSet(-sort(i), :);
        s.vals = mock_structure_add(s.vals, x, s.f(x'));
        results.fvals = results.fvals + 1;
        
        % Here we should see if the points are already in the
        % datastructure...
    end
end

% test that the datastructure is still correct...
test_structure(s);


[vals, ~, ds] = mock_structure_get(s.vals, poisedSet);
if max(ds) > 1e-6
    'Did not find a point that was supposed to be in vals'
end


% The coefficients of the model at each basis
s.model_coeff = sum(diag(vals) * lagrange);
% Evaluate the model at a single column vector.
s.model = @(x) sum(s.model_coeff .* params.basis_eval(x'));
% Evaluate the model at several row vectors at once.
s.model_multi = @(x) sum(diag(s.model_coeff) * params.basis_eval(x)')';

s.g = params.interp_grad_eval(s.model_coeff, s.model_center);


% This is for plotting purposes...
s.interpolation_set = poisedSet;


%poisedSet = shuffle_matrix(poisedSet, sort);
test_lagrange(params, s.model_multi, s.model, improvedSet, poisedSet, vals, s.f);

end