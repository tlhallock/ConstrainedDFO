% phi is a basis created basis_create
% coef is a row vector of coefficients

function [extrema] = basis_extrema(phi, coef)
  [c b A] = basis_to_matrix(phi, coef);
  
  extrema = struct();
  
  xmin = trust( b',  2 * A);
  xmax = trust(-b', -2 * A);
  
  f =@(x)(c + b * x + x' * A * x);
  f1Val = f(xmin);
  f2Val = f(xmax);
  
  extrema.minVal =  f(xmin);
  extrema.minX = xmin;
  
  if abs(f1Val) > abs(f2Val)
    extrema.maxVal = abs(f1Val);
    extrema.maxX = xmin;
  else
    extrema.maxVal = abs(f2Val);
    extrema.maxX = xmax;
  end
  
endfunction




