function test_sort(s)
  % Test the sorted indices:
  for i = 1:length(s.vals)
    if (abs(norm(s.vals(i) - s.f(s.poisedSet(i, :)')))) > .001
      i
      'The values vector is no longer sorted'
%      throw 1
      s.vals(i) = s.f(s.poisedSet(i, :));
    end
  end
endfunction