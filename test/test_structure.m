function test_structure( s )

siz = size(s.vals.xs, 1);

if siz < 1
    return
end

for i = 1:siz
    x = s.vals.xs(i, :)';
    y = s.f(x);
    if norm(y - s.vals.ys(i,:)') / norm(y) > 1e-8;
        'The datastructure does not hold the right values'
    end
end



for i = 1:10
    idxs = randperm(siz);
    sizeToTest = 1 + floor((siz-1) * rand);
    idxs = idxs(1:sizeToTest);
    test = zeros(sizeToTest, size(s.vals.xs, 2));
    for j = 1:length(idxs);
        test(j,:) = s.vals.xs(idxs(j),:);
    end
    vals = mock_structure_get(s.vals, test);
    for j = 1:size(vals, 1)
        y = s.f(test(j, :)');
        if norm(y - vals(j,:)') / norm(y)> 1e-8;
            'The datastructure does not hold the right values'
        end
    end
end




end

