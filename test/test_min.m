function [fail ] = test_min(c, b, A, r, xmin)

fail = 0;

f = @(x)(c + b'*x + x'*A*x);
fVal = f(xmin);
h = .05;

for i = 1:50
  x0 = xmin + h * 2 * rand(size(b)) - 1;
  
  if norm(x0) > 1
    x0 = x0 / norm(x0);
  end
  
  if f(x0) < fVal
    'not even a local minimum'
     fail = 1;
     return;
  end
end



for i = 1:50
  x0 = 2 * rand(size(b)) - 1;
  
  if norm(x0) > 1
    x0 = x0 / norm(x0);
  end
  
  if f(x0) < fVal
    'not a global minimum'
    fail = 1;
    return;
  end
end


endfunction