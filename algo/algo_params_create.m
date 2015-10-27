
function [s] = algo_params_create(dim, deg)
  s = struct();
  
  s.dim = dim;
  s.deg = deg;
  phi = poly_create(dim, deg);
  
  s.eta0 = 1/3;
  s.eta1 = 2/3;
  s.gamma = .5;
  s.gamma_inc = 1.5;
  s.eps_c = 50;
  s.mu = 5;
  s.beta = 3
  s.omega = .5;
  s.radius_max = 50;
  
  s.max_iters = 10000;
  
  s.tolerance = .005;
  
  s.xsi = 1e-4;
end
