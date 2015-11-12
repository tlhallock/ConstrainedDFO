function [derivative] = poly_diff(p, var)
  derivative = poly_clone(p);
  
  for j = 1:size(p.powers, 2);
    if derivative.powers(var, j) == 0
      derivative.coeffs(j) = 0;
    else
      derivative.coeffs(j) = derivative.coeffs(j) * derivative.powers(var, j);
      derivative.powers(var, j) = derivative.powers(var, j) - 1;
    end
  end

end