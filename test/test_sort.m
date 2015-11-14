function test_sort(original, sorted, sort, vals)
% Test the sorted indices:
for i = 1:length(sort)
    if sort(i) < 0
        % If sort says the x is new, then it should not be in vals
        [~, ~, dist] = mock_structure_get(vals, sorted(-sort(i), :));
        if dist < 1e-8
            ' this point should not be in vals.'
        end
        continue
    else
        [~, ~, dist] = mock_structure_get(vals, sorted(sort(i), :));
        if dist > 1e-8
            'this point should be in vals'
        end
    end
    
    if norm(original(sort(i), :)- sorted(i, :)) > 1e6
        'The values vector is no longer sorted'
        throw 1
    end
end
end