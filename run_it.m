
%f = @(x) (((x(1) - 1)^2 + (x(2)^4)) * (- cos(x(1) * cos(x(2)))));


env

%f = @(x) (...
%(x(1) - 1)^2 + (x(2) - 1)^2 + ...
%cos ((x(1) - 1)^2 + (x(2) - 1)^2) ...
%+ x(1) + x(2) ...
%);


f = @(x) ((50 - x(1))^4 + (52-x(2))^2);

%f = @(x) (5 * sin(x(1) * x(2)));


%f = @(x)((1-x(1))^2 + 100*(x(2)-x(1)^2)^2);
x0 = [0.0358; 1.0619];

%x0 = [-50;-50];
%x0 = [-1; -1];
deg = 2;



params = algo_create_params(length(x0), deg);

params.x0 = x0;
params.f = f;

results = algo(params);












lbx = min(results.xs(:,1)) - 5;
ubx = max(results.xs(:,1)) + 5;
lby = max(results.xs(:,2)) - 5;
uby = max(results.xs(:,2)) + 5;
npoints = 50;
x = linspace(lbx, ubx, npoints);
y = linspace(lby, uby, npoints);
z = zeros(length(x), length(y));

%phi = basis_create(2, 2);
%[c b A] = basis_to_matrix(phi, s.model);
%modelf = @(x) ( c + b * x + x' * A * x );

for i = 1:length(x)
    for j = 1:length(y)
        z(i,j) = f([x(i); y(j)]);
    end
end

z = z';


contourf(x,y,z);
h = figure;
hold on
% first plot
scatter (results.xs(:,1), results.xs(:,2), [], linspace(1,10,size(results.xs, 1)), 'filled');

saveas(h, 'imgs/iterates.png', 'png');

close(h);

hold off


