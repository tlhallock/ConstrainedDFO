
%f = @(x) (((x(1) - 1)^2 + (x(2)^4)) * (- cos(x(1) * cos(x(2)))));







f = @(x) (...
(x(1) - 1)^2 + (x(2) - 1)^2 + ...
cos ((x(1) - 1)^2 + (x(2) - 1)^2) ...
);


x0 = [-1;-1];
deg = 2;












dim = length(x0);

params = algo_params_create(dim, deg);
results = algo_results_create();
s = algo_state_create(params, f, x0, deg);

s.vals(:) = f(x0);
results.fvals = results.fvals + 1;









  s.model_radius = s.radius;

  shiftedSet = zeros(size(s.poisedSet));
  for i=1:size(shiftedSet, 1);
    shiftedSet(i, :) = (s.poisedSet(i, :) - s.model_center') / s.radius;
  end
  
  [shiftedSet, lagrange, fail, sort] = algo_certify(params, shiftedSet);
  s.lagrange = lagrange;
  
  for i = 1:size(shiftedSet, 1)
    s.poisedSet(i, :) = shiftedSet(i, :) * s.radius + s.model_center';
  end
  
  newVals = s.vals;
  for i = 1:length(sort)
    if sort(i) < 1
      newVals(i) = s.f(     s.poisedSet(i, :)'     );
      results.fvals = results.fvals + 1;
    else
      newVals(i) = s.vals(i);
    end
  end
  
  s.vals = newVals;
  
  test_sort(s);
  test_lagrange(s);
  print_lambda(s);
  
  scatter(s.poisedSet(:,1)', s.poisedSet(:, 2)');




























[params, s, results] = algo_poise(params, s, results);
linear = 1;
  model = poly_add(s.lagrange, s.vals);
  
  
  g = poly_grad_eval(model, s.iterate);