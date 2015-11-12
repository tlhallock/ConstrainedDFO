
p.coeffs = zeros(1,6);
p.coeffs(5) = 1;

m = 5;
npoints = 100;
x = linspace(-m, m, npoints);
y = linspace(-m, m, npoints);
z = zeros(length(x), length(y));

for i = 1:length(x)
  for j = 1:length(y)
%    z(i,j) = poly_eval(p, [x(i); y(j)]);
    z(i,j) = f([x(i); y(j)]);
  end
end

surf(x,y,z);
