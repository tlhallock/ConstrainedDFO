function [s] = algo_state_create(params)

s = struct();
s.dim = length(params.x0);
s.radius = 1;
s.model_center = params.x0;
s.fullyLinear = false;
s.f = params.f;
s.interpolation_set = repmat(params.x0', params.basis_dimension, s.radius);

s.vals = mock_structure_create(s.dim, 1);
s.vals = mock_structure_add(s.vals, params.x0', params.f, s.radius);


s.plot_number = 0;

%s.poisedSet  = repmat(x0', phi.basis_dimension, 1) + radius * (2*rand(phi.basis_dimension, dim) - 1);

end
