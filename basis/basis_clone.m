function p = basis_clone(phi)
  p = struct();
  p.n = phi.n;
  p.deg = phi.deg;
  p.powers = phi.powers;
  p.coeff = phi.coeff;
  p.basis_dimension = phi.basis_dimension;
endfunction