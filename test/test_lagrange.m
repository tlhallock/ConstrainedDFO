function test_lagrange(params, s)

  lagrangeValues = s.lagrange * params.basis_eval(...
    (s.poisedSet - s.model_center') / s.model_radius)';
  error = eye(size(lagrangeValues)) - lagrangeValues;
  
  if norm(error) / norm(lagrangeValues) > 1e8
    'lagrange property not satisfied'
    throw 1
  end

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
endfunction