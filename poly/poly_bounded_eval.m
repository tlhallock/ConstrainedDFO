function [y] = poly_bounded_eval(p, x, outOfBounds);
% This should be an absolute value, and should be called within a maximum...

if norm(x) <= 1
%  y = poly_eval(p, x);
  y = -abs(poly_eval(p, x));
else
  y = outOfBounds;
end

endfunction
