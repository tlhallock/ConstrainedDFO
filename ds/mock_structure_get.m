function [ys, xs, ds] = mock_structure_get(st, x)

npoints = size(x, 1);
ys = repmat(-1, npoints, st.ydim);
xs = repmat(-1, npoints, st.xdim);
ds = repmat(1e300, npoints, 1);

for j = 1:npoints
    for i = 1:size(st.xs, 1)
        d = norm(st.xs(i, :) - x(j,:));
        if d >= ds(j)
            continue;
        end
        
        xs(j, :) = st.xs(i, :);
        ys(j, :) = st.ys(i, :);
        ds(j) = d;
    end
end

end