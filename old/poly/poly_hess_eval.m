function [h] = poly_hess_eval(p, x)

h = zeros(p.n);

for i = 1:p.n
  for j = 1:p.n
    h(i,j) = poly_eval(poly_diff(poly_diff(p , i), j), x);
  end
end

end
