function test_interpolation(params, s)

  % Code to test interpolation model...
  for i = 1:size(s.poisedSet, 1)
    if abs(poly_eval(model, ((s.poisedSet(i,:)' - s.iterate) / s.radius)) - s.f(s.poisedSet(i,:)')) > .01
      'model is constructed wrong'
      i
    end
  end
  
endfunction