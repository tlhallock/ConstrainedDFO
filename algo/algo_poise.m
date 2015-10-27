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
  
  % Test the sorted indices:
  for i = 1:length(s.vals)
    if (abs(norm(s.vals(i) - s.f(s.poisedSet(i, :)')))) > .001
      i
      'The values vector is no longer sorted'
      throw 1
    end
  end
  
  % Test the lagrange property of the polynomials
  for i = 1:size(s.poisedSet, 1)
    for k = 1:length(lagrange);
      if k == i
        if abs(poly_eval(s.lagrange{k}, ((s.poisedSet(i,:)' - s.model_center) / s.radius)) - 1) > .001
          'fail to have lagrange property'
          throw 1
        end
      else
        if abs(poly_eval(s.lagrange{k}, ((s.poisedSet(i,:)' - s.model_center) / s.radius))) > .001
          'fail to have lagrange property'
          throw 1
        end
      end
    end
  end
  
  % Also not needed: simply calculates lambda
  % This should be done with the sort as well, and when the point is added...
  for i = 1:s.phi.basis_dimension
    f=@(x)(poly_bounded_eval(lagrange{i}, x, 1e300));
    [newX fVal] = fminsearch(f, shiftedSet(i,:)');
    lambda1 = abs(poly_eval(lagrange{i}, newX));
    [newX fVal] = fminsearch(f, zeros(size(shiftedSet, 2), 1));
    lambda2 = abs(poly_eval(lagrange{i}, newX));
    s.lambdas(i) = max(lambda1, lambda2);
  end
  lambda = max(s.lambdas)
  
  scatter(s.poisedSet(:,1)', s.poisedSet(:, 2)');
end