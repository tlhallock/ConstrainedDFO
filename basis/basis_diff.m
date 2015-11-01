function [derivative] = basis_diff(p, var)
  derivative = basis_clone(p);
  
  for j = 1:size(p.powers, 2);
    if derivative.powers(var, j) == 0
      derivative.coeff(j) = 0;
    else
      derivative.coeff(j) = derivative.coeff(j) * derivative.powers(var, j);
      derivative.powers(var, j) = derivative.powers(var, j) - 1;
    end
  end

endfunction