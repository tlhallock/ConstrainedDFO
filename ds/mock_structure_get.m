function [y minX minD] = mock_structure_get(st, x)
  minX = -1;
  minD = 1e300;
  y = -1;

  for i = 1:size(st.xs)
    d = norm(st.xs(i, :) - x);
    if d < minD
      minX = st.xs(i, :);
      y = st.ys(i, :);
      minD = d;
    end
  end
endfunction
