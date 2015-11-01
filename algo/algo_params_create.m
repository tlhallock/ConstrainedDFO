
function [s] = algo_params_create(dim, deg)
  s = struct();
  
  s.dim = dim;
  s.deg = deg;
  
  phi = basis_create(dim, deg);
  % evaluates the basis functions at a set of points
  s.basis_eval = @(x)(basis_eval(phi, x));
  % evaluates the gradient as a given point
  s.basis_grad_eval = @(x)(basis_grad_eval(phi, x));
  % evaluates the a set of interpolation coefficients at a point x
  s.interp_eval = @(c, x)(basis_interp_eval(phi, c, x));
  % finds the local extrema of the basis functions with given coefficients in the unit ball about the origin
  s.interp_extrema = @(c)(basis_extrema(phi, c));
  s.basis_dimension = phi.basis_dimension;
  
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
