function [lambdas, lambda] = get_lambda(params, lagrange)





lambdas = zeros(1, size(lagrange, 2));
for i = 1:params.basis_dimension
    lambdas(i) = params.interp_extrema(lagrange(i , :)).maxVal;
end
lambda = max(lambdas);
end
