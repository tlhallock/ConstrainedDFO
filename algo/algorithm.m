function [results] = algorithm(params)

results = algo_results_create();
s = algo_state_create(params, f, params.x0, params.deg);

s.vals(:) = f(x0);
results.fvals = results.fvals + 1;

[params, s, results] = algo_poise(params, s, results);
linear = 1;

for step = 1:params.max_iters

    s = algo_clean_poised_set(s);
  [params, s, results] = algo_poise(params, s, results);
  linear = 1;
  
  s.model = sum(diag(s.vals) * s.lagrange);
  
  plot_state(params, s, strcat('imgs/model.', int2str(results.iterations)));
  
  test_interpolation(params, s);
  
  g = params.interp_grad_eval(s.model, ((s.poisedSet(s.index, :) - s.model_center)/s.model_radius)' );
  while norm(g) < params.eps_c ...
        && params.mu * norm(g) < s.radius  ...
        && results.iterations < params.max_iters ...
        && s.radius < s.tolerance
    s.radius = min(max(...
      s.radius * s.omega,... 
        s.beta * norm(g)), s.radius);
    s = algo_clean_poised_set(s);
    [params, s, results, fail] = algo_poise(para  ms, s, results);
    results.iterations = results.iterations + 1;
    linear = 1;
  end
  
  % open ball, closed ball
%  inter = @(x)(poly_eval(model, (x - s.model_center) / s.model_radius));
%  [sqpIterate, sqpObj, sqpInfo, sqpIter, sqpNf, sqpLambda] = ...
%      sqp(s.model_center, inter, [], [], 
%      s.xmin - s.radius,
%      s.xmin + s.radius);
  extrema = params.interp_extrema(s.model);
  
  % test minimum
  for i = 1:1000
    x0 = 2 * rand(size(s.poisedSet, 2), 1) - 1;
    if norm(x0) >= 1
      x0 = .9 * x0 / norm(x0);
    end
    if params.interp_eval(s.model, x0) < extrema.minVal
      'found smaller point'
    end
  end
  
  newX = extrema.minX * s.model_radius + s.model_center;
  
  newVal = f(newX);
  results.fvals = results.fvals + 1;
  rho = (s.vals(s.index) - newVal) / (s.vals(s.index) - extrema.minVal);
  
  plot_state(params, s, strcat('imgs/newpoint.', int2str(results.iterations)), newX);
  
  if rho >= params.eta1
    s.radius = min(params.gamma_inc * s.radius, params.radius_max);
  else
    if linear
      s.radius = params.gamma * s.radius
      
      s = algo_clean_poised_set(s);
    end
  end
  
  if rho > params.eta0
    % replace the point farthest away from the current iterate
    [_ mIndex] = max(arrayfun(@(idx) norm(s.poisedSet(idx, :) - newX'), 1:size(s.poisedSet, 1)));
    
    s.poisedSet(mIndex, :) = s.poisedSet(1,:);
    s.vals(mIndex) = s.vals(1);
    
    s.poisedSet(1, :) = newX';
    s.vals(1) = newVal;
    linear = 0;
  end
  
  if rho < params.eta1 && !linear
      [params, s, results, fail] = algo_poise(params, s, results);
      linear = 1;
    end
  end
  
  [_ index] = min(s.vals);
  s.index = index;
%  s = algo_clean_poised_set(s);
  
  results.iterations = results.iterations + 1;
end

endfunction
