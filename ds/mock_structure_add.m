function [st, newVals] = mock_structure_add(st, x, f, r)

if st.xdim ~= size(x, 2)
    'bad domain size'
    throw 1
end

newVals = zeros(0, st.ydim);

for i = 1:size(x,1)
    found = false;
    for j = 1:size(st.xs, 1)
        if norm(st.xs(j, :) - x(i, :)) / r < 1e-8
            found = true;
            newVals = [newVals; st.ys(j, :)];
            break;
        end
    end
    
    if found
        continue
    end
    
    
    newVal = f(x(i, :)')';
    if st.ydim ~= size(newVal, 2)
        'bad image size'
        throw 1
    end
    
    newVals = [newVals ; newVal];
    st.xs   = [st.xs; x(i, :)];
    st.ys   = [st.ys; newVal];
end

end
