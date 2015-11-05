
%f = @(x) (((x(1) - 1)^2 + (x(2)^4)) * (- cos(x(1) * cos(x(2)))));







f = @(x) (...
(x(1) - 1)^2 + (x(2) - 1)^2 + ...
cos ((x(1) - 1)^2 + (x(2) - 1)^2) ...
);


x0 = [-1;-1];
deg = 2;



params = algo_params_create(length(x0), deg);

params.x0 = x0;
params.f = f;

algorithm(params);

