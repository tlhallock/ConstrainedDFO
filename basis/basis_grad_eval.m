function [q] = basis_grad_eval(p, model, x)
  q = zeros(p.n, 1);

  for var = 1:p.n
    q(var) = sum(basis_eval(basis_diff(p, var), x') .* model);
  end
endfunction
