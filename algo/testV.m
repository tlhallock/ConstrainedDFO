function testV(V, i, phi, msg, p, npoints, h, initialPoints, old)

  
  for j = 1:p
    for k = 1:p
      expected = V(k, j);
      actual = poly_eval(poly_clone(phi, V ((npoints+1):h,j)'), initialPoints(k, :)');
      if abs(expected - actual) > .001
      
      poly_clone(phi, V ((npoints+1):h,j)')
      
      
      
      msg
      
      
      'old:'
      old
      
      'iteration: '
      i
      'poly:'
        j
        'point:'
        k
      'expected'
      expected
      'actual:'
      actual
      '2'
        V
        
        
        'point:'
        initialPoints(k, :)'
        
        throw 1
      end
    end
  end
  
  
endfunction