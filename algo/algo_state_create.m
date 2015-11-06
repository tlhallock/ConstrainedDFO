function [state] = algo_state_create(params)
  s = struct();
  
  s.dim = length(params.x0);
  
  %s.poisedSet  = repmat(x0', phi.basis_dimension, 1) + radius * (2*rand(phi.basis_dimension, dim) - 1);
  s.poisedSet  = repmat(params.x0', params.basis_dimension, 1);
  s.f = params.f;
  s.vals = mock_structure_create();
  
  s.radius = 1;
  s.index = 1;
  
  s.model_center = params.x0;
  s.model_radius = s.radius;
  
  % Must be filled in later...
  s.lagrange = [];
  s.lambdas  = [];
  
  s.constraints = [];
  
  state = s;
endfunction
