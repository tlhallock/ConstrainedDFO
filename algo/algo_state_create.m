function [state] = algo_state_create(params, f, x0, deg)
  s = struct();
  
  s.dim = length(x0);
  
  %s.poisedSet  = repmat(x0', phi.basis_dimension, 1) + radius * (2*rand(phi.basis_dimension, dim) - 1);
  s.poisedSet  = repmat(x0', params.basis_dimension, 1);
  s.f = f;
  s.vals = zeros(1, length(s.poisedSet));
  
  s.radius = 1;
  s.index = 1;
  
  s.model_center = x0;
  s.model_radius = s.radius;
  
  % Must be filled in later...
  s.lagrange = [];
  s.lambdas  = [];
  
  s.constraints = [];
  
  state = s;
endfunction
