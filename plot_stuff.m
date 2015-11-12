function plot_stuff(m, modelf, r, points)

%phi = basis_create(2,2);
%v = rand(1, 6);
%v = [0 0 0 0 1 0];
%[c b A] = basis_to_matrix(phi, v);

npoints = 100;
x = linspace(-m, m, npoints);
y = linspace(-m, m, npoints);
z = zeros(length(x), length(y));

%modelf = @(x) ( c + b * x + x' * A * x );

for i = 1:length(x)
  for j = 1:length(y)
    z(i,j) = modelf([x(i); y(j)]);
  end
end

z = z';

ang=0:0.01:2*pi; 
xp = r * cos(ang);
yp = r * sin(ang);

hold on
contourf(x,y,z);

colors = repmat([1 0 0], size(points, 1), 1);

points
scatter (points(:, 1), points(:, 2), [], colors, 'filled');
  
plot(xp, yp, 'Color', [1 1 0]);

hold off

end