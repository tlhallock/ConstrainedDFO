
p.coeffs = zeros(1,6);
p.coeffs(5) = 1;






m = 1;
npoints = 100;
x = linspace(-m, m, npoints);
y = linspace(-m, m, npoints);
z = zeros(length(x), length(y));
[c b A] = basis_to_matrix(phi, coef);
f = @(x) ( c + b * x + x' * A * x );

for i = 1:length(x)
  for j = 1:length(y)
    z(i,j) = f([x(i); y(j)]);
  end
end

surf(x,y,z);
