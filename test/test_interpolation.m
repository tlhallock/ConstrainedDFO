function test_interpolation(params, s)
  % Code to test interpolation model...
  for i = 1:size(s.poisedSet, 1)
    expected = params.interp_eval(s.model, (s.poisedSet(i, :)' - s.model_center) / s.radius);
    actual = s.vals(i);
    
    if abs(expected - actual) / actual > 1e-6
      'Model is inaccurate'
      throw 1
    end
  end
  
endfunction