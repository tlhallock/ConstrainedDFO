function [s] = algo_state_create(params)
  s = struct();
  
  s.dim = length(params.x0);
  
  %s.poisedSet  = repmat(x0', phi.basis_dimension, 1) + radius * (2*rand(phi.basis_dimension, dim) - 1);
  s.f = params.f;
  s.vals = mock_structure_create(s.dim, 1);
  
  s.radius = 1;
  
  s.model_center = params.x0;
end
