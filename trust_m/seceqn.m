function[value] = seceqn(lambda,eigval,alpha,delta)
%SEC	Secular equation
%
% value = SEC(lambda,eigval,alpha,delta) returns the value
% of the secular equation at a set of m points lambda

m = length(lambda); n = length(eigval);
unn = ones(n,1); unm = ones(m,1);
M = eigval*unm' + unn*lambda'; MC = M;
MM = alpha*unm';
M(M~=0) = MM(M~=0) ./ M(M~=0);
M(MC==0) = Inf; 
M = M.*M;
value = sqrt(unm ./ (M'*unn));
value(isnan(value)) = 0;
value = (1/delta)*unm - value;


endfunction

