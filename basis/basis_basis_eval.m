function [y] = basis_interp(phi, c, x)
	diag(c) * basis_eval(phi, x);
end
