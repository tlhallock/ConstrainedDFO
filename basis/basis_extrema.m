% phi is a basis created basis_create
% coef is a row vector of coefficients

function [extrema] = basis_extrema(phi, coef)
  [c, b, A] = basis_to_matrix(phi, coef);
  r = 1;
  
  SMALL = 1e-6;
  
  extrema = struct();
  
  f =@(x)(c + b * x + x' * A * x);
  
  if max(max(abs(2*A))) < SMALL
    if abs(norm(b)) < SMALL
        xmin = zeros(size(b'));
        xmax = xmin;
    else
        xmin = -r * b' / norm(b);
        xmax =  r * b' / norm(b);
    end
  else
    xmin = trust( b',  2 * A, 1);
    xmax = trust(-b', -2 * A, 1);
  end

  
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
  
end

