function [results] = algorithm(f, x0, deg)

dim = length(x0);

params = algo_params_create(dim, deg);
results = algo_results_create();
s = algo_state_create(params, f, g, x0, deg);

s.vals(:) = f(x0);
results.fvals = results.fvals + 1;

[params, s, results, fail] = algo_poise(params, s, results);
linear = 1;

for step = 1:params.max_iters
  model = poly_add(s.lagrange, s.vals);
  
  % Code to test interpolation model...
  for i = 1:size(s.poisedSet, 1)
    if abs(poly_eval(model, ((s.poisedSet(i,:)' - s.iterate) / s.radius))...
     - s.f(s.poisedSet(i,:)')) > .01
      'model is constructed wrong'
      i
    end
  end
  
  g = poly_grad_eval(model, s.iterate);
  while norm(g) < params.eps_c ...
        && params.mu * norm(g) < s.radius  ...
        && results.iterations < params.max_iters ...
        && s.radius < s.tolerance
    s.radius = min(max(...
      s.radius * s.omega,... 
      s.beta * norm(g)), s.radius);
    s = clean_poised_set(s);
    [params, s, results, fail] = algo_poise(params, s, results);
    results.iterations = results.iterations + 1;
    linear = 1;
  end
  
  % open ball, closed ball
  inter = @(x)(poly_eval(model, (x - s.model_center) / s.model_radius));
  [sqpIterate, sqpObj, sqpInfo, sqpIter, sqpNf, sqpLambda] = ...
      sqp(s.model_center, inter, [], [], 
      s.xmin - s.radius,
      s.xmin + s.radius);
  
  newVal = f(sqpIterate);
  results.fvals = results.fvals + 1;
  rho = (vals(index) - newVal) / (vals(index) - sqpIterate)
  

  if rho >= params.eta_1
    s.radius = max(params.gammainc * s.radius, params.radius_max)
    s.poisedSet(1,:) = sqpIterate';
    s.vals(1) = newVal;
    s.xmin = sqpIterate;
  else
    if linear
      s.radius = params.gamma * s.radius
    else
      [params, s, results, fail] = algo_poise(params, s, results);
    end
  end
  
  [_ index] = min(s.vals);
  s.xmin = s.poisedSet(index, :)';
  s = clean_poised_set(s);
  
  results.iterations = results.iterations + 1;
end

endfunction
