function test_lagrange_property(s)
  % Test the lagrange property of the polynomials
  for i = 1:size(s.poisedSet, 1)
    for k = 1:length(lagrange);
      if k == i
        if abs(poly_eval(s.lagrange{k}, ((s.poisedSet(i,:)' - s.model_center) / s.radius)) - 1) > .001
          'fail to have lagrange property'
          throw 1
        end
      else
        if abs(poly_eval(s.lagrange{k}, ((s.poisedSet(i,:)' - s.model_center) / s.radius))) > .001
          'fail to have lagrange property'
          throw 1
        end
      end
    end
  end
endfunction