% phi is a basis created basis_create
% poly is a row vector of coefficients



% This is more verboise than it has to be because sometimes octave didn't do 
% a good job of minimizing a function with an abs(...) inside of it.
function [extrema] = basis_extrema(phi, coef, testPoints)
  [c b A] = basis_to_matrix(phi, coef);
  
  extrema = struct();
  M = 1e300;

  nvars = size(phi.powers, 1);
  
  extrema.minVal = M;
  extrema.maxVal = -M;
  
  f1 =@(x)(ternary(norm(x) < 1,   c + b * x + x' * A * x, M));
  f2 =@(x)(ternary(norm(x) < 1, - c - b * x - x' * A * x, M));
  
  % try zero
  x0 = zeros(nvars, 1);
  
  extrema = update_extrema(f1, nvars, extrema, x0);
  [newX fVal] = fminsearch(f1, x0);
  extrema = update_extrema(f1, nvars, extrema, newX);
  [newX fVal] = fminsearch(f2, x0);
  extrema = update_extrema(f1, nvars, extrema, newX);

  % use the guesses...
  if nargin > 2
    for i = 1:size(testPoints, 1)
      x0 = testPoints(i, :)';
      extrema = update_extrema(f1, nvars, extrema, x0);
      [newX fVal] = fminsearch(f1, x0);
      extrema = update_extrema(f1, nvars, extrema, newX);
      [newX fVal] = fminsearch(f2, x0);
      extrema = update_extrema(f1, nvars, extrema, newX);
    end
  end
  
  
  % monty carlo optimization
  for i = 1:10
    x0 = 2 * rand(nvars, 1) - 1;
    if norm(x0) >= 1
      x0 = .9 * x0 / norm(x0);
    end
    
      extrema = update_extrema(f1, nvars, extrema, x0);
      [newX fVal] = fminsearch(f1, x0);
      extrema = update_extrema(f1, nvars, extrema, newX);
      [newX fVal] = fminsearch(f2, x0);
      extrema = update_extrema(f1, nvars, extrema, newX);
  end
  
  % monty carlo optimization
  for i = 1:100
    x0 = 2 * rand(nvars, 1) - 1;
    if norm(x0) >= 1
      x0 = .9 * x0 / norm(x0);
    end
    extrema = update_extrema(f1, nvars, extrema, x0);
  end
  
  
  % try in the direction of steepest descent
  if cond(A) < 1e12
    x0 = (b / A) ';
    x0 = .9 * x0 / norm(x0);
    
      extrema = update_extrema(f1, nvars, extrema, x0);
      [newX fVal] = fminsearch(f1, x0);
      extrema = update_extrema(f1, nvars, extrema, newX);
      [newX fVal] = fminsearch(f2, x0);
      extrema = update_extrema(f1, nvars, extrema, newX);
  end
endfunction




