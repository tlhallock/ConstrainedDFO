function testV(params, V, shiftedSet)

  npoints = size(shiftedSet, 1);
  p = size(V, 2);
  h = size(V, 1);

  if (norm(V(1:npoints, :) - params.basis_eval(shiftedSet) * V((npoints+1):h, :))) > .005
    throw 1
  end


%
%
%  % for point i
%  for i = 1:npoints
%    % for basis j
%    for j = 1:p
%      % expected value is 
%	      expected = V(j, i);
%        params.interp_eval(V((npoints+1):h, i)', initialPoints(j,:))
%    end
%  end
 
%  for j = 1:p
%    for k = 1:p
%      expected = V(k, j);
%      actual = poly_eval(poly_clone(phi, V ((npoints+1):h,j)'), initialPoints(k, :)');
%      if abs(expected - actual) > .001
%      
%      poly_clone(phi, V ((npoints+1):h,j)')
%      
%      
%      
%      msg
%      
%      
%      'old:'
%      old
%      
%      'iteration: '
%      i
%      'poly:'
%        j
%        'point:'
%        k
%      'expected'
%      expected
%      'actual:'
%      actual
%      '2'
%        V
%        
%        
%        'point:'
%        initialPoints(k, :)'
%        
%        throw 1
%      end
%    end
%  end
  
  
end
