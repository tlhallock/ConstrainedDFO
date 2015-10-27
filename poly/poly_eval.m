% Accepts a polynomial generated from create_poly and a column vector to evaluate it at

function [value] = poly_eval (p, x)
  value = sum(prod(repmat(x, 1, size(p.powers, 2)) .^ p.powers) .* p.coeffs);
endfunction


%  if size(x, 1) == 1 && size(x,2) != 1
%    x = x';
%  end




% After several hours of debugging, I realized, that this is different from:
%  value = sum(prod((repmat(x, 1, size(p.powers, 2)) .^ p.powers) .* p.coeffs));




%  repmat(x, 1, size(p.powers, 2))
%  repmat(x, 1, size(p.powers, 2)) .^ p.powers
%  sum(prod(repmat(x, 1, size(p.powers, 2)) .^ p.powers) .* p.coeffs)

