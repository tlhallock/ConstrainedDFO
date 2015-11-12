function [c b A] = basis_to_matrix(phi, coef)

%nvars = size(phi.powers, 1);

tot = sum(phi.powers);
for i = 1:size(phi.powers, 2)
  if tot(i) == 0
    c = phi.coeff(i) * coef(i);
    continue;
  end
  
  if tot(i) == 1
    ndx = find(phi.powers(:, i));
    b(ndx) = phi.coeff(i) * coef(i);
    continue;
  end
  
  if tot(i) == 2
    ndxs = find(phi.powers(:, i));
    if length(ndxs) > 1
      A(ndxs(1), ndxs(2)) = phi.coeff(i) * coef(i) / 2;
      A(ndxs(2), ndxs(1)) = phi.coeff(i) * coef(i) / 2;
    else
      A(ndxs, ndxs) = phi.coeff(i) * coef(i);
    end
    continue;
  end
  
  'Can only put a quadratic function into matrix form'
  throw 1
end



end
