% phi is a basis, created by basis_create
% c is a row or column vector of ceofficients
% x is a matrix where the rows are the different points to be evaluated

function [y] = basis_interp_eval(phi, c, x)
  y = sum(diag(c) * basis_eval(phi, x')');
end
