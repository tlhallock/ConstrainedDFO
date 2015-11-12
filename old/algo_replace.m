
function [s] = algo_replace(s, newX, newVal)
  [_ mIndex] = max(arrayfun(@(idx) norm(s.poisedSet(idx, :) - newX'), 1:size(s.poisedSet, 1)));
  s.poisedSet(mIndex, :) = newX;
  s.vals(mIndex) = newVal;
end
