
function [params] = algo_params_create(dim, deg)
  params = struct();
  
  params.dim = dim;
  params.deg = deg;
  
  phi = basis_create(dim, deg);
  % evaluates the basis functions at a set of points
  params.basis_eval = @(x)(basis_eval(phi, x));
  % evaluates the gradient as a given point
  params.interp_grad_eval = @(c, x)(basis_grad_eval(phi, c, x));
  % evaluates the a set of interpolation coefficients at a point x
  params.interp_eval = @(c, x)(basis_interp_eval(phi, c, x));
  % finds the local extrema of the basis functions with given coefficients in the unit ball about the origin
  params.interp_extrema = @(c)(basis_extrema(phi, c));
  params.basis_dimension = phi.basis_dimension;
  
  params.eta0 = 1/10;
  params.eta1 = .5;
  params.gamma = .5;
  params.gamma_inc = 1.5;
  
  params.eps_c = 5e-2;
  params.lambda_max = 50;
  
  params.mu = 5;
  params.beta = 3
  params.omega = .5;
  params.radius_max = 50;
  
  params.max_iters = 5;
  
  params.tolerance = .005;
  
  params.xsi = 1e-4;
end
