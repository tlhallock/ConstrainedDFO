function test_interpolation(params, lagrange, vals, shiftedSet, poisedSet)
  % Code to test interpolation model...
  
  % doesn't have to be a for loop, if use model_multi
  for i = 1:size(s.poisedSet, 1)
    expected = s.model(shiftedSet(i, :));
    actual = mock_structure_get(vals, poisedSet(i, :));
    
    if abs(expected - actual) / actual > 1e-6
      'Model is inaccurate'
      throw 1
    end
  end
  
end