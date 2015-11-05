


for file in $(find . | egrep *.m$ | grep -v old)
do
  grep -v \; -n $file | grep -v for | grep -v if | grep -v end | grep -v throw | grep -v function
done




f = 1;
g = rand(5,1);
B = rand(5,5); B = .5 * (B + B');
r = 1;
[xmin fVal] = quad_extrema(f, g, B, r);



for i = 1:1000
  w = rand(size(g));
  w = r * w / norm(w);
  if h(w) < h(xmin)
    'not exact'
    w
  end
end























eigs = eig(B);
l1 = max(eigs(eigs<0));



p = @(l) (norm(...
  (B+l*eye(size(B)))\g ...
     ) - r);
maxi = 1;
while p(maxi) > 0
  maxi = 2 * maxi;
end

mini = 1;
while p(mini) < 0
  mini = (-l1 + mini) / 2;
end


while abs(maxi - mini) > 1e-12
  x = (maxi + mini) / 2;
  v = p(x);
  if v < 0
    maxi = x;
  else
    mini = x;
  end
end

     
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
  p = pl;
end


f = @(x) (g' * x + .5*x'*B*x);





for i = 1:1000
  w = rand(5,1);
  w = r * w / norm(w);
  if f(w) < f(p)
    'not exact'
    w
  end
end



