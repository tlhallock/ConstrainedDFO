function test_to_matrix()


for i = 1:10
  nvars = round(2 + 3 * rand);
  phi = basis_create(2, 2);
  coef = rand(1, phi.basis_dimension);
  [c, b, A] = basis_to_matrix(phi, coef);
  for j = 1:100
    x = rand(2, 1);
    matrixResult = c + b * x + x' * A * x;
    evalResult   = basis_interp_eval(phi, coef, x);
    
    if norm(matrixResult - evalResult) > .001
      'The matrix evaluation did not match the basis evaluation'
      throw 1
    end
  end
end


endfunction
