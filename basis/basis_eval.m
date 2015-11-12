% Accepts a polynomial generated from create_poly and a row vector to evaluate it at

function [value] = basis_eval (p, x)
  npoints = size(x, 1);
  value = zeros(npoints, p.basis_dimension);

  for i = 1:npoints
	  value(i, :) = prod(repmat(x(i,:)', 1, size(p.powers, 2)) .^ p.powers) .* p.coeff;
  end
end

