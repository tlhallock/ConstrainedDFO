function [st] = mock_structure_add(st, x, y)
  st.xs = [st.xs; x];
  st.ys = [st.ys; y];
endfunction
