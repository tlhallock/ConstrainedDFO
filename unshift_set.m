function [ poised ] = unshift_set(shifted, center, radius)

poised = zeros(size(shifted));
for i = 1:size(shifted, 1)
    poised(i, :) = shifted(i, :) * radius + center;
end

end
