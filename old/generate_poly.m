function [poly] = generate_poly(numVars, highestDegree)

n = numVars;
k = highestDegree;


polys = zeros(n, nchoosek(n+k-2, k-1)) + 1;
coeffs = zeros(n, nchoosek(n+k-2, k-1)) + 1;

powers = zeros(n,1);
powers(1) = k;

index = 1;
while true
    polys(:, index) = powers;
    index = index + 1;
  
    nonzero = find(powers);
    
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