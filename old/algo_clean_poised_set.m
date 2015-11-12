function [s] = algo_clean_poised_set(s)
% Remove all vectors too far away

  xmin = s.poisedSet(s.index, :);
  for i = 1:size(s.poisedSet, 1)
    if norm(xmin - s.poisedSet(i, :)) > s.radius
      s.poisedSet(i, :) = xmin;
      s.vals(i) = s.vals(s.index);
      
      'cleaning point ' 
      i
    end
  end
end