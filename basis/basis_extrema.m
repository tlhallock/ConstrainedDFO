function [xs vals] = basis_extrema(phi, poly)


basis_extrema

    lagrange_poly = poly_clone(phi, V((npoints+1):h, i)');
    f=@(x)(poly_bounded_eval(lagrange_poly, x, 1e300));
    [newX fVal] = fminsearch(f, zeros(dim, 1));
    
	
% Find the vertex

%A

% x'Ax 



endfunction
