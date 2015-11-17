function test_lagrange(params, model_multi, model, shiftedSet, poisedSet, vals, f)

% Now this actually tests the interpolation...


  % Check that the model_multi returns values
  lagrangeValues = model_multi(shiftedSet);
  
  error = abs(vals - lagrangeValues) / norm(lagrangeValues);
  
  if error > 1e-8
    'lagrange property not satisfied'
    throw 1
  end
  
  for i = 1:size(shiftedSet, 1)
      % interpolation not valid
      assert_close(model(shiftedSet(i, :)'), vals(i));
      assert_close(f(poisedSet(i, :)'), vals(i));
  end
    
  % Test that each of the functions 

%  % Test the lagrange property of the polynomials
%  for i = 1:size(s.poisedSet, 1)
%    for k = 1:length(lagrange);
%      if k == i
%        if abs(poly_eval(s.lagrange{k}, ((s.poisedSet(i,:)' - s.model_center) / s.radius)) - 1) > .001
%          'fail to have lagrange property'
%          throw 1
%        end
%      else
%        if abs(poly_eval(s.lagrange{k}, ((s.poisedSet(i,:)' - s.model_center) / s.radius))) > .001
%          'fail to have lagrange property'
%          throw 1
%        end
%      end
%    end
%  end
end