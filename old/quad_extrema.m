function [xmin fVal l] = quad_extrema(f, g, B, r)

B = 2*B;

h = @(x) (f + g' * x + .5 * x'*B*x);

if max(max(abs(B))) < 1e-6
  'linear case'
  xmin = -r * g / norm(g);
  fVal = h(xmin);
  return;
end



xmin = -B\g;
if norm(xmin) < 1
  'interior case'
  fVal = h(xmin);
  return;
end

[V D] = eig(B);
eigs = diag(D);

if length(find(eigs < 0)) == 0
  'positive definite case'
  l = 0;
  xmin = -B\g;
  fVal = h(xmin);
  
  xmin = xmin / norm(xmin);
  return;
end




%q1 = V(:, max(find(eigs < 0)));
l1 = min(eigs);
q1 = V(:, find(eigs == l1));


if abs(q1'*g) < 1e-6
  'hard case'
end

%l1 = max(eigs(eigs<0));
     
p2 = @(l) (1/norm((B+l*eye(size(B)))\g) - 1/r);
maxi = l1 + 1;
while p2(maxi) < 0
  maxi = 2 * maxi;
end

mini = l1 + 1;
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
xmin = -(B + maxi * eye(size(B))) \ g;
fVal = h(xmin);

%l = maxi;
%for i = 1:10
%  R = chol(B + l * eye(size(B)));
%  pl = - R\R'\g;
%  ql = R'\pl;
%  
%  l = l + (norm(pl) / norm(ql))^2 * ((norm(pl) - r) / r);
%end
%
%xmin = pl / norm(pl);
%fVal = h(pl);
%
%if norm(pl) > r
%  'not in domain'
%end

end
