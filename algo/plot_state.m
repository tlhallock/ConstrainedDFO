function [newplotnum] = plot_state(s, newX)

m = 5;
npoints = 50;
x = linspace(-m, m, npoints);
y = linspace(-m, m, npoints);
z1 = zeros(length(x), length(y));
z2 = zeros(length(x), length(y));

%phi = basis_create(2, 2);
%[c b A] = basis_to_matrix(phi, s.model);
%modelf = @(x) ( c + b * x + x' * A * x );

for i = 1:length(x)
    for j = 1:length(y)
        z1(i,j) = s.f([x(i); y(j)]);
        z2(i,j) = s.model(([x(i); y(j)] - s.model_center) / s.radius);
    end
end

z1 = z1';
z2 = z2';

ang=0:0.01:2*pi;
xp=s.radius*cos(ang);
yp=s.radius*sin(ang);

h = figure;






subplot(1,2,1)

hold on
% first plot
contourf(x,y,z1);

plot(s.model_center(1)+xp, s.model_center(2)+yp, 'Color', [1 0 0]);
hold off







subplot(1,2,2)
% second plot

hold on
contourf(x,y,z2);

plot(s.model_center(1)+xp, s.model_center(2)+yp, 'Color', [1 0 0]);


points = s.interpolation_set;

npoints = size(points, 1);
colors = repmat([1 0 0], npoints, 1);

% Color the center differently
center_is_in_model = false;
for i = 1:npoints;
    if norm(points(i, :) - s.model_center') / norm(s.model_center') < 1e-6
        colors(i, :) = [0 1 0];
        center_is_in_model = true;
        break;
    end
end

if ~center_is_in_model
    points = [points; s.model_center'];
    colors = [colors;[1 1 1]];
end

if nargin > 1
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


newplotnum = s.plot_number + 1;
saveas(h, strcat(strcat('imgs/', int2str(newplotnum)), '_newpoint.png'), 'png');

hold off

close(h);

%algo_print(s, strcat(filename, '.txt'));

end
