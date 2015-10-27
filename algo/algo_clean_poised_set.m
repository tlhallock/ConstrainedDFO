function [s] = algo_clean_poised_set(s)
% Remove all vectors too far away
  for i = 1:size(s.poisedSet, 1)
    if norm(s.xmin' - s.poisedSet(i, :)) > s.radius
      s.poisedSet(i, :) = s.xmin';
      s.vals(i) = s.vals(index);
    end
  end
end