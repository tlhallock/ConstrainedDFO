function [y] = poly_basis_eval(p, x)
  y = prod((repmat(x, 1, size(p.powers, 2)) .^ p.powers) .* p.coeffs);
end
