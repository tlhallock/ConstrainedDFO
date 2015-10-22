function [poisedSet, lagrange, fail] = poise(initialPoints, d, toler, center, radius)

fail = 0;
npoints = size(initialPoints,1);
dim     = size(initialPoints,2);



functions;
p = length(functions{dim, d}(initialPoints(1,:)));
%remPoints = min(npoints, p);

h = npoints + p;
V = zeros(h, p);

for i = 1:npoints
    V(i,1:p) = functions{dim, d} (initialPoints(i,:));
end

V((npoints + 1):h,:) = eye(p, p);


for i=1:p
        maxVal = abs(max(V(i:npoints,i)));
        
        if maxVal < toler
			'Set not poised: '
			V
			'Replacing index: '
			i
            coes = V((npoints+1):h, i)'
            f=@(x)(boundedPoly(x, functions{dim, d}, coes));
            [newX fVal] = fminsearch(f, zeros(1,dim));
            if fVal < toler
                fail = 1;
				lagrange = -1;
				poisedSet = -1;
                return;
            end
            
            V(i,1:p) = functions{dim, d}(newX).*coes;
            maxVal = abs(max(V(i:npoints,i)));
        end
        
        maxRow = i-1 + find(abs(V(i:npoints, i)) == maxVal)(1);
        if maxRow != i
            newRow = V(maxRow,:);
            oldRow = V(i,:);
            
            V(maxRow,:) = oldRow;
            V(i,:) = newRow;
            
            
            newRow = initialPoints(maxRow,:);
            oldRow = initialPoints(i,:);
            
            initialPoints(maxRow,:) = oldRow;
            initialPoints(i,:) = newRow;
        end
		
		V(:,i) = V(:,i) / V(i,i);
        
        for j=1:p
			if i == j
				continue
			end
            V(:,j) = V(:,j) - V(i, j)*V(:, i);
        end
end


%V((npoints+1):h, :) * fliplr(vander(initialPoints));
%V((npoints+1):h, :)' * fliplr(vander(initialPoints))';



lagrange = V ((npoints+1):h,:);
poisedSet = initialPoints;

end
