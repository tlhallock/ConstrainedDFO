function [ shifted ] = shift_set(points, center, radius)

shifted = zeros(size(points));
for i = 1:size(points, 1)
    shifted(i, :) = (points(i, :) - center) / radius;
end

end
