function [x0] = quad_extrema2(c, b, A)

f = @(x)(c + b'*x + x'*A*x);

x0 = rand(size(b));
x0 = x0 / norm(x0);
fmin = 1e300;

mult = 10;

tol = 1e-6;

while mult > tol
  count = 0;
  while count < 100
    otherx = x0 + mult * rand(size(b));
    otherx = otherx / norm(otherx);
    otherf = f(otherx);
    if otherf < fmin
      count = 0;
      fmin = otherf
      x0 = otherx;
      continue;
    end
    count = count + 1;
  end
  mult = mult / 2;
end


end
