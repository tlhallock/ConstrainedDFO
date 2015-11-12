
function p = poly_create(n, deg)
  
  p = struct();
  %p.polys = zeros(n, nchoosek(n+k-2, k-1)) + 1;
  %p.coeffs = zeros(n, nchoosek(n+k-2, k-1)) + 1;

  p.n = n;
  p.deg = deg;
  
  index = 1;
  for k = 0:deg
    powers = zeros(n,1);
    powers(1) = k;
    constant = 1/factorial(k);
    while true
      p.powers(:, index) = powers;
      p.coeffs(index) = constant;
      
      % Should make this natural basis...
      p.coeffs(index) = 1;
      
      
      
      
      index = index + 1;
    
      nonzero = find(powers);
      if length(nonzero) == 0
        break;
      end
      if powers(nonzero(1)) == k
          if nonzero(1) == length(powers)
              break;
          end
          powers = zeros(n, 1);
          powers(1) = k-1;
          powers(nonzero(1)+1) = 1;
      else
          powers(nonzero(1)) = powers(nonzero(1)) - 1;
          powers(nonzero(1)+1) = powers(nonzero(1)+1) + 1;
      end
    end
  end
  
  p.basis_dimension = size(p.powers, 2);

end