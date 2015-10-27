function [poisedSet, lagrange, fail, sort] = algo_certify(params, initialPoints)

fail = 0;
npoints = size(initialPoints,1);
dim     = size(initialPoints,2);
sort = 1:npoints;

phi = poly_create(params.dim, params.deg);
if size(initialPoints, 1) != phi.basis_dimension
  'not the right number of points 409187430'
  size(initialPoints)
  phi.basis_dimension
end
p = phi.basis_dimension;

h = npoints + p;
V = zeros(h, p);

for i = 1:npoints
    V(i,1:p) = poly_basis_eval(phi, initialPoints(i,:)');
end

V((npoints + 1):h,:) = eye(p, p);
for i=1:p
  maxVal = max(abs(V(i:npoints,i)));
  if maxVal < params.xsi
    lagrange_poly = poly_clone(phi, V((npoints+1):h, i)');
    f=@(x)(poly_bounded_eval(lagrange_poly, x, 1e300));
    [newX fVal] = fminsearch(f, zeros(dim, 1));
    
    if abs(fVal) < params.xsi
      fail = 1;
      lagrange = -1;
      poisedSet = -1;
      return;
    end
    
    sort(i) = -1;
    
    saved = V;
    for j = 1:phi.basis_dimension
      V(i,j) = poly_eval(poly_clone(phi, V((npoints+1):h, j)'), newX);
    end
    initialPoints(i, :) = newX';
    maxVal = max(abs(V(i:npoints,i)));
    
    testV(V, i, phi, 'changing points', p, npoints, h, initialPoints, saved);
  end
        
  saved = V;
  maxRow = i-1 + find(abs(V(i:npoints, i)) == maxVal)(1);
  if maxRow != i
    % Swap the rows in V
    newRow = V(maxRow,:);
    oldRow = V(i,:);
    V(maxRow,:) = oldRow;
    V(i,:) = newRow;
    
    % Swap the points
    newRow = initialPoints(maxRow,:);
    oldRow = initialPoints(i,:);
    initialPoints(maxRow,:) = oldRow;
    initialPoints(i,:) = newRow;
    
    % Swap the sort indices
    newRow = sort(maxRow);
    oldRow = sort(i);
    sort(maxRow) = oldRow;
    sort(i) = newRow;
  end
  testV(V, i, phi, 'row exchange', p, npoints, h, initialPoints, saved);
  
  saved = V;
  V(:,i) = V(:,i) / V(i,i);
  testV(V, i, phi, 'normalized', p, npoints, h, initialPoints, saved);
  
  saved = V;
  for j=1:p
    if i == j
      continue
    end
    V(:,j) = V(:,j) - V(i, j)*V(:, i);
  end
  testV(V, i, phi, 'reduced', p, npoints, h, initialPoints, saved);
end

for i = 1:phi.basis_dimension
  lagrange{i} = poly_clone(phi, V ((npoints+1):h,i)');
end

%lagrange = V ((npoints+1):h,:)';
poisedSet = initialPoints;

endfunction


% debugging statements:

%poly_eval(poly_clone(phi, V((npoints+1):h, 1)'), initialPoints(1,:)')

%  for i = 1:npoints
%    for j = 1:phi.basis_dimension
%      V(i,j) = poly_eval(poly_clone(phi, V((npoints+1):h, j)'), initialPoints(i, :)');
%    end
%  end























% Old code to delete when committed once:

%    V
%    'maximize: '
%    lagrange_poly
    
    

%    xMax = zeros(dim, 1);
% Giving up, this should I am trying to figure out why the new maximums are never 
% in the lower left hand corner quadrant...
%    f=@(x)(poly_bounded_eval(lagrange_poly, x, 1e300));
%    [newX1 fVal1] = fminsearch(f, xMax);
%    f=@(x)(-poly_bounded_eval(lagrange_poly, x, -1e300));
%    [newX2 fVal2] = fminsearch(f, xMax);
    
    
%Found the bug, now this can probably be removed and put back to its simple form
% Last idea, use the one furthest from others?
%    if abs(fVal1) == abs(fVal2)
%      totDist1 = 0;
%      totDist2 = 0;
%      for j = 1:i
%        totDist1 = totDist1 + norm(newX1 - initialPoints(i,:)');
%        totDist2 = totDist2 + norm(newX2 - initialPoints(i,:)');
%      end
%      if totDist1 > totDist2
%        newX = newX1; fVal = fVal1;
%      else
%        newX = newX2; fVal = fVal2;
%      end
%    end
%    if abs(fVal1) < abs(fVal2)
%      newX = newX2; fVal = fVal2;
%    else
%      newX = newX1; fVal = fVal1;
%    end
    
    
    
%    xMax = zeros(dim, 1);
%%%%%%%%%% This is dumb, but trying to give matlab a good start, otherwise it gives bad points as maximum
%xMax = zeros(dim, 1);
%fMax = f(xMax);
%local_search_count = 0;
%while local_search_count < 100;
%  xOther = 2 * rand(dim, 1)  - 1;
%  if norm(xOther) > 1
%    continue;
% end
% fOther = f(xOther);
%  if abs(fOther) > abs(fMax)
%    fMax = fOther;
%    xMax = xOther;
%  end
%  local_search_count = local_search_count + 1;
%end
%%%%%%%%%%%%%%%%%%%%%%%%
