function [s,val,posdef,count,lambda] = trust(g,H,delta)
%TRUST	Exact soln of trust region problem
%
% [s,val,posdef,count,lambda] = TRUST(g,H,delta) Solves the trust region
% problem: min{g^Ts + 1/2 s^THs: ||s|| <= delta}. The full
% eigen-decomposition is used; based on the secular equation,
% 1/delta - 1/(||s||) = 0. The solution is s, the value
% of the quadratic at the solution is val; posdef = 1 if H
% is pos. definite; otherwise posdef = 0. The number of
% evaluations of the secular equation is count, lambda
% is the value of the corresponding Lagrange multiplier.
%
%
% TRUST is meant to be applied to very small dimensional problems.

%   Copyright 1990-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/07/06 20:46:16 $

% INITIALIZATION
tol = 10^(-12); 
tol2 = 10^(-8); 
key = 0; 
itbnd = 50;
lambda = 0;
n = length(g); 
coeff(1:n,1) = zeros(n,1);
H = full(H);
[V,D] = eig(H); 
count = 0;
eigval = diag(D); 
[mineig,jmin] = min(eigval);
alpha = -V'*g; 
sig = sign(alpha(jmin)) + (alpha(jmin)==0);

% POSITIVE DEFINITE CASE
if mineig > 0
   coeff = alpha ./ eigval; 
   lambda = 0;
   s = V*coeff; 
   posdef = 1; 
   nrms = norm(s);
   if nrms <= 1.2*delta
      key = 1;
   else 
      laminit = 0;
   end
else
   laminit = -mineig; 
   posdef = 0;
end

% INDEFINITE CASE
if key == 0
   if seceqn(laminit,eigval,alpha,delta) > 0
      [b,c,count] = rfzero('seceqn',laminit,itbnd,eigval,alpha,delta,tol);
      vval = abs(seceqn(b,eigval,alpha,delta));
      if vval <= tol2
         lambda = b; 
         key = 2;
         lam = lambda*ones(n,1);
         w = eigval + lam;
         arg1 = (w==0) & (alpha == 0); 
         arg2 = (w==0) & (alpha ~= 0);
         coeff(w ~=0) = alpha(w ~=0) ./ w(w~=0);
         coeff(arg1) = 0;
         coeff(arg2) = Inf;
         coeff(isnan(coeff))=0;
         s = V*coeff; 
         nrms = norm(s);
         if (nrms > 1.2*delta) || (nrms < .8*delta)
            key = 5; 
            lambda = -mineig;
         end
      else
         lambda = -mineig; 
         key = 3;
      end
   else
      lambda = -mineig; 
      key = 4;
   end
   lam = lambda*ones(n,1);
   if (key > 2) 
      arg = abs(eigval + lam) < 10 * eps * max(abs(eigval),1);
      alpha(arg) = 0;
   end
   w = eigval + lam;
   arg1 = (w==0) & (alpha == 0); arg2 = (w==0) & (alpha ~= 0);
   coeff(w~=0) = alpha(w~=0) ./ w(w~=0);
   coeff(arg1) = 0;
   coeff(arg2) = Inf;
   coeff(isnan(coeff))=0;
   s = V*coeff; nrms = norm(s);
   if (key > 2) && (nrms < .8*delta)
      beta = sqrt(delta^2 - nrms^2);
      s = s + beta*sig*V(:,jmin);
   end
   if (key > 2) && (nrms > 1.2*delta)
      [b,c,count] = rfzero('seceqn',laminit,itbnd,eigval,alpha,delta,tol);
      lambda = b; lam = lambda*(ones(n,1));
      w = eigval + lam;
      arg1 = (w==0) & (alpha == 0); arg2 = (w==0) & (alpha ~= 0);
      coeff(w~=0) = alpha(w~=0) ./ w(w~=0);
      coeff(arg1) = 0;
      coeff(arg2) = Inf;
      coeff(isnan(coeff)) = 0;
      s = V*coeff; nrms = norm(s);
   end
end
val = g'*s + (.5*s)'*(H*s);
