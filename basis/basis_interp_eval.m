function [y] = basis_interp(phi, c, x)
	y = diag(c) * basis_eval(phi, x);
endfunction
