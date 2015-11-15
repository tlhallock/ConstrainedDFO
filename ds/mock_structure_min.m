function [ xmin, minVal] = mock_structure_min( st )

[minVal, minIdx] = min(st.ys);
minVal = minVal';
xmin  = st.xs(minIdx, :)';

end

