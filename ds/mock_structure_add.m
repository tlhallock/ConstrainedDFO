function [st] = mock_structure_add(st, x, y, r)

if st.xdim ~= size(x, 2)
    'bad domain size'
    throw 1
end
if st.ydim ~= size(y, 2)
    'bad image size'
    throw 1
end


for i = 1:size(x,1)
    found = false;
    for j = 1:size(st.xs, 1)
        if norm(st.xs(j, :) - x(i, :)) / r < 1e-8
            'point already in set'
            found = true;
            break;
        end
    end
    
    if found
        continue
    end
    
    st.xs = [st.xs; x];
    st.ys = [st.ys; y];
end

end
