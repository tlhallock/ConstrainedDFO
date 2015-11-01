function [params, s, results, fail] = algo_poise(params, s, results)
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
end