function [p] = poly_add(ps, interpolationVals)

p = poly_clone(ps{1}, zeros());
for i = 1:length(ps)
  p.coeffs = p.coeffs + interpolationVals(i) * ps{i}.coeffs;
end

end