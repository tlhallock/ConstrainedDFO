function [q] = poly_grad_eval(p, x)

q = zeros(p.n, 1);

for var = 1:p.n
  q(var) = poly_eval(poly_diff(p, var), x);
end

end
