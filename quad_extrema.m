function [xmin fVal] = quad_extrema(f, g, B, r)

h = @(x) (f + g' * x + .5*x'*B*x);

if max(max(abs(B))) < 1e-6
  xmin = -r * g / norm(g);
  fVal = h(xmin);
  return;
end

[V D] = eig(B);
eigs = diag(D);

if length(find(eigs < 0)) == 0
  'simple case 1'
  xmin = -B\g;
  fVal = h(xmin);
  
  if norm(xmin) > r
    'not in domain'
  end
  return;
end

q1 = V(:, max(find(eigs < 0)));


if abs(q1'*g) < 1e-6
  'hard case'
end

l1 = max(eigs(eigs<0));





%p = @(l) (norm(...
%  (B+l*eye(size(B)))\g ...
%     ) - r);
     
p2 = @(l) (1/norm((B+l*eye(size(B)))\g) - 1/r);
maxi = 1;
while p2(maxi) < 0
  maxi = 2 * maxi;
end

mini = 1;
while p2(mini) > 0
  mini = (-l1 + mini) / 2;
end

while abs(maxi - mini) > 1e-15
  x = (maxi + mini) / 2;
  v = p2(x);
  if v > 0
    maxi = x;
  else
    mini = x;
  end
end

l = maxi;
for i = 1:10
  R = chol(B + l * eye(size(B)));
  pl = - R\R'\g;
  ql = R'\pl;
  
  l = l + (norm(pl) / norm(ql))^2 * ((norm(pl) - r) / r);
end

xmin = ql;
fVal = h(ql);

if norm(ql) > r
  'not in domain'
end

endfunction
