function testV(params, state, V, shiftedSet)

  npoints = size(shiftedSet, 1);
  p = size(V, 2);
h = size(shiftedSet, 2);


  for i = 1:npoints
    for j = 1:p
	      expected = V(K, j);
params.basis_interp_eval(V((npoints+1):h, ), initialPoints());
    end
  end








  
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
  
  
endfunction
