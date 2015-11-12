function [bestSet] = algo_get_interpolation_set(params, s)


% This SHOULD use the points that are best for interpolation.
% Right now, it just uses the closest ones.
% (The points will be fixed to be lambda poised later, this is candidate point selection algorithm)

if size(s.vals.xs, 1) < 1
    'Have to have atleast one interpolation point.'
    throw 1
end


% This would limit the set to only including those points that are within
% the current radius:
bestSet = mock_structure_find_all(s.vals, s.model_center, params.basis_dimension, s.radius);
%bestSet = mock_structure_find_all(s.vals, s.model_center, params.basis_dimension);
bestSet = fillMat(bestSet, params.basis_dimension);

end
