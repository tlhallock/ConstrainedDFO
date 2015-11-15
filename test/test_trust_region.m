function test_trust_region(params, s, poisedSet)

for i = 1:size(poisedSet, 1)
    if norm(poisedSet(i, :) - s.model_center') > params.outer_trust_region * s.radius
        poisedSet(i, :)
        s.model_center'
        poisedSet(i, :) - s.model_center'
        norm(poisedSet(i, :) - s.model_center')
        s.radius
        'Picked points too far away from the model center'
%        algo_get_interpolation_set(params, s)
        throw 1
    end
end

end

