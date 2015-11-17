function [ results ] = algo_update_results(s, results)

results.iterations = results.iterations + 1;
results.fmin = min(s.vals.ys);
[xmin, minVal] = mock_structure_min(s.vals);
results.fmin = minVal;
results.xmin = xmin;
results.fvals = size(s.vals.ys, 1);
results.g = s.g;

end

