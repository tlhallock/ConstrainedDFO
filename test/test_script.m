




phi = basis_create(2,2);
v = rand(1, 6);
r = 1;
v = [1 0 0 0 0 0 ];

[c b A] = basis_to_matrix(phi, v);
[xmin fVal] = trust(b', 2 * A, r);
f = @(x) (c + b*x + x'*A*x);

failed = test_min(c, b', A, r, xmin);
if failed 
  'that is not good'
  plot_stuff(2, f, r, xmin');
end

