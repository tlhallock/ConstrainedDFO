function [retVal] = mock_structure_find_all(st, x, num, r)


npoints = size(st.xs, 1);
diffs = st.xs - repmat(x', npoints, 1);
ds = sqrt(sum((diffs.^2), 2));
%expensive
[~, idx] = sort(ds);
if nargin > 3 && r > 0
%    nidx = zeros(size(idx));
%    for i = 1:nidx
%        if ds(idx(i)) < r
%            nd
%    end
    idx = idx(ds(idx) < r);
end

nret = min(num, length(idx));
retVal = zeros(nret, size(st.xs, 2));
for i = 1:nret
   retVal(i,:) = st.xs(idx(i), :); 
end


end
