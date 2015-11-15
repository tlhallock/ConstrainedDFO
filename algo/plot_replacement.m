function [newplotnum] = plot_replacement(s, newSet)

oldSet = s.interpolation_set;

sizeOld = size(oldSet, 1);
sizeNew = size(newSet, 1);

xs = [];
ys = [];
colors = [];


% Need to know the denominator of relative difference...
relativeSize = get_relative_difference(oldSet);

inOld = false(1, sizeNew);
for i = 1:sizeOld
    found = false;
    for j = 1:sizeNew
        if max(abs(( newSet(j,:) - oldSet(i, :)) ./ relativeSize)) < 1e-6
            % These vectors are the same...
            inOld(j) = true;
            found = true;
            break;
        end
    end
    
    xs = [xs; oldSet(i, 1)];
    ys = [ys; oldSet(i, 2)];
    
    if found
        % nothing changed
        colors = [colors ; [0 0 1]];
    else
        % point removed
        colors = [colors ; [1 0 0]];
    end
end

for i = 1:sizeNew
    if inOld(i)
        % skip, it was in the old one too
        continue
    end
    
    xs = [xs; newSet(i, 1)];
    ys = [ys; newSet(i, 2)];
    colors = [colors ; [0 1 0]];
end


hold on
h = figure;
scatter(xs, ys, [], colors);
newplotnum = s.plot_number + 1;
saveas(h, strcat(strcat('imgs/', int2str(newplotnum)), '_improvement.png'), 'png');
hold off
close(h);



%
%
% TODO: add this test
%
%
%
% inOld = repmat(false, 1, sizeOld);
%
% for i = 1:sizeOld
%     [~, foundX] = mock_structure_get(vals, oldSet(i, :));
%     if max(abs((oldSet(i, :) - foundX) ./ relativeSize)) > 1e-6;
%         % did not find it, check that it was negative in sort
%         if sort(i) >= 0
%             'sort missed a new vector'
%         end
%
%         inOld(i) = false;
%     end
%     % Check if it was in sort
% end
%
% for i = 1:sizeOld
%
% end
%


end

