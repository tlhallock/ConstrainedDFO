function print_lambda(params, s)

  % Also not needed: simply calculates lambda
  % This should be done with the sort as well, and when the point is added...
  
  shiftedSet = (s.poisedSet - s.model_center') / s.radius;
  
  for i = 1:params.basis_dimension
    s.lambdas(i) = params.interp_extrema(s.lagrange(i, :), shiftedSet).maxVal;
%    f=@(x)(poly_bounded_eval(lagrange{i}, x, 1e300));
%    [newX fVal] = fminsearch(f, shiftedSet(i,:)');
%    lambda1 = abs(poly_eval(lagrange{i}, newX));
%    [newX fVal] = fminsearch(f, zeros(size(shiftedSet, 2), 1));
%    lambda2 = abs(poly_eval(lagrange{i}, newX));
%    s.lambdas(i) = max(lambda1, lambda2);
  end
  s.lambda = max(s.lambdas);
  
endfunction