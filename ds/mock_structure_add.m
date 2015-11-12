function [st] = mock_structure_add(st, x, y)
    if st.xdim ~= size(x, 2)
        'bad domain size'
        throw 1
    end
    if st.ydim ~= size(y, 2)
        'bad image size'
        throw 1
    end
  st.xs = [st.xs; x];
  st.ys = [st.ys; y];
end
