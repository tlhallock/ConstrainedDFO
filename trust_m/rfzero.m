
function [b,c,itfun] = rfzero(FunFcn,x,itbnd,eigval,alpha,delta,tol)
%RFZERO Find zero to the right
%
%	[b,c,itfun] = rfzero(FunFcn,x,itbnd,eigval,alpha,delta,tol)
%	Zero of a function of one variable to the RIGHT of the
%       starting point x. A small modification of the M-file fzero,
%       described below, to ensure a zero to the Right of x is
%       searched for.
%
%	RFZERO is a slightly modified version of function FZERO

%	FZERO(F,X) finds a zero of f(x).  F is a string containing the
%	name of a real-valued function of a single real variable.   X is
%	a starting guess.  The value returned is near a point where F
%	changes sign.  For example, FZERO('sin',3) is pi.  Note the
%	quotes around sin.  Ordinarily, functions are defined in M-files.
%
%	An optional third argument sets the relative tolerance for the
%	convergence test.   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	C.B. Moler 1-19-86
%	Revised CBM 3-25-87, LS 12-01-88.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This algorithm was originated by T. Dekker.  An Algol 60 version,
%  with some improvements, is given by Richard Brent in "Algorithms for
%  Minimization Without Derivatives", Prentice-Hall, 1973.  A Fortran
%  version is in Forsythe, Malcolm and Moler, "Computer Methods
%  for Mathematical Computations", Prentice-Hall, 1976.
%
% Initialization
if nargin < 7, tol = eps; end
itfun = 0;
%
%if x ~= 0, dx = x/20;
%if x ~= 0, dx = abs(x)/20;
if x~= 0 
    dx = abs(x)/2;
   %
   %else, dx = 1/20;
else
    dx = 1/2;
end
%
%a = x - dx;  fa = feval(FunFcn,a,eigval,alpha,delta);
a = x; c = a;  fa = feval(FunFcn,a,eigval,alpha,delta);
itfun = itfun+1;
%
b = x + dx;
b = x + 1;
fb = feval(FunFcn,b,eigval,alpha,delta);
itfun = itfun+1;

% Find change of sign.

while (fa > 0) == (fb > 0)
   dx = 2*dx;
   %
   %  a = x - dx;  fa = feval(FunFcn,a);
   %
   if (fa > 0) ~= (fb > 0), break, end
   b = x + dx;  fb = feval(FunFcn,b,eigval,alpha,delta);
   itfun = itfun+1;
   if itfun > itbnd, break; end
end

fc = fb;
% Main loop, exit from middle of the loop
while fb ~= 0
   % Insure that b is the best result so far, a is the previous
   % value of b, and c is on the opposite of the zero from b.
   if (fb > 0) == (fc > 0)
      c = a;  fc = fa;
      d = b - a;  e = d;
   end
   if abs(fc) < abs(fb)
      a = b;    b = c;    c = a;
      fa = fb;  fb = fc;  fc = fa;
   end
   
   % Convergence test and possible exit
   %
   if itfun > itbnd, break; end
   m = 0.5*(c - b);
   toler = 2.0*tol*max(abs(b),1.0);
   if (abs(m) <= toler) || (fb == 0.0), break, end
   
   % Choose bisection or interpolation
   if (abs(e) < toler) || (abs(fa) <= abs(fb))
      % Bisection
      d = m;  e = m;
   else
      % Interpolation
      s = fb/fa;
      if (a == c)
         % Linear interpolation
         p = 2.0*m*s;
         q = 1.0 - s;
      else
         % Inverse quadratic interpolation
         q = fa/fc;
         r = fb/fc;
         p = s*(2.0*m*q*(q - r) - (b - a)*(r - 1.0));
         q = (q - 1.0)*(r - 1.0)*(s - 1.0);
      end;
      if p > 0, q = -q; else p = -p; end;
      % Is interpolated point acceptable
      if (2.0*p < 3.0*m*q - abs(toler*q)) && (p < abs(0.5*e*q))
         e = d;  d = p/q;
      else
         d = m;  e = m;
      end;
   end % Interpolation
   
   % Next point
   a = b;
   fa = fb;
   if abs(d) > toler, b = b + d;
   else if b > c, b = b - toler;
      else b = b + toler;
      end
   end
   fb = feval(FunFcn,b,eigval,alpha,delta);
   itfun = itfun + 1;
end % Main loop

