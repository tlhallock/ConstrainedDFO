function [params, s, results, fail] = algo_poise(params, s, results)
  s.model_radius = s.radius;
  s.model_center = s.poisedSet(s.index);

  s.shiftedSet = (s.poisedSet - s.model_center') / s.radius;
  
  [s, sort, fail] = algo_certify(params, s);
  
  s.poisedSet  = s.shiftedSet * s.radius + s.model_center';
  
  for i = 1:length(sort)
    if sort(i) < 1
      s.vals(i) = s.f(     s.poisedSet(i, :)'     );
      results.fvals = results.fvals + 1;
    end
  end
  
  
  test_sort(s);
  test_lagrange(params, s);
  print_lambda(params, s);
  
%  scatter(s.poisedSet(:,1)', s.poisedSet(:, 2)');
end