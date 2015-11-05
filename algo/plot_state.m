function plot_state(params, s, filename, newX)


m = 5;
npoints = 100;
x = linspace(-m, m, npoints);
y = linspace(-m, m, npoints);
z1 = zeros(length(x), length(y));
z2 = zeros(length(x), length(y));


phi = basis_create(2, 2);
[c b A] = basis_to_matrix(phi, s.model);
modelf = @(x) ( c + b * x + x' * A * x );

for i = 1:length(x)
  for j = 1:length(y)
    z1(i,j) = s.f([x(i); y(j)]);
    z2(i,j) = modelf([x(i); y(j)]);
  end
end

  ang=0:0.01:2*pi; 
  xp=s.radius*cos(ang);
  yp=s.radius*sin(ang);

h = figure;

subplot(1,2,1)

hold on
%make here your first plot
contourf(x,y,z1);

  plot(s.poisedSet(s.index, 1)+xp, s.poisedSet(s.index, 2)+yp, 'Color', [1 1 0]);
hold off

subplot(1,2,2)
%make here your second plot

hold on

  contourf(x,y,z2);


  plot(s.poisedSet(s.index, 1)+xp, s.poisedSet(s.index, 2)+yp, 'Color', [1 1 0]);
  
  colors = repmat([1 0 0], size(s.poisedSet, 1), 1);
  colors(s.index, :) = [0 1 0];
  
  points = s.poisedSet;
  
  if nargin > 3
    points = [points; newX'];
    colors = [colors; [1 0 1]];
  end
  
  scatter (points(:, 1), points(:, 2), [],  colors, 'filled');
  
%  for i = 1:size(s.poisedSet, 1)
%    if i == s.index
%      scatter (s.poisedSet(i, 1), s.poisedSet(i, 2));
%    else
%      scatter (s.poisedSet(i, 1), s.poisedSet(i, 2));
%    end
%  end
%  scatter(s.poisedSet(:,1)', s.poisedSet(:, 2)');
%  scatter(s.poisedSet(s.index, 1), s.poisedSet(s.index, 2), 'Color', [1 1 0], 'd');


hold off



saveas(h, filename, 'png');
close(h);


endfunction
