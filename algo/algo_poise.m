function [params, s, results, fail] = algo_poise(params, s, results)
  s.model_radius = s.radius;
  s.model_center = s.poisedSet(s.index);

  shiftedSet = (s.poisedSet - s.model_center') / s.radius;
  
  [shiftedSet, lagrange, fail, sort] = algo_certify(params, shiftedSet);
  s.lagrange = lagrange;
  
  s.poisedSet  = shiftedSet * s.radius + s.model_center';
  s.shiftedSet = shiftedSet; 
  
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
  test_lagrange(params, s);
  print_lambda(params, s);
  
  scatter(s.poisedSet(:,1)', s.poisedSet(:, 2)');
end