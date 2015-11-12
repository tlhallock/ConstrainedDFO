function q = poly_clone(p, coeffs)

q = struct();
q.n = p.n;
q.deg = p.deg;
q.powers = p.powers;
switch nargin
  case 1
    q.coeffs = p.coeffs;
  case 2
    q.coeffs = coeffs;
  otherwise
  'bad number of arguments to poly_clone';
end
q.basis_dimension = p.basis_dimension;

end