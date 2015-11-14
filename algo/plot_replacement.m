function plot_replacement(oldSet, newSet, vals, sort)

sizeOld = size(oldSet, 1);
sizeNew = size(newSet, 1);

xs = [];
ys = [];
colors = [];


% Need to know the denominator of relative difference...
relativeSize = zeros(1, size(oldSet, 2));
for i = 1:sizeOld
    for j = 1:sizeOld
        relativeSize = max(relativeSize, abs(oldSet(i,:) - oldSet(j,:)));
    end
end

inOld = repmat(false, 1, sizeNew);
for i = 1:sizeOld
    found = false;
    for j = 1:sizeNew
        if max(abs(( newSet(j,:) - oldSet(i, :)) ./ relativeSize)) < 1e-6
            % These vectors are the same...
            
            % Make sure they are not in sort
            
            % TODO:
            % test if in vals
            % Test if in sort
            
            inOld(j) = true;
            found = true;
            break;
        end
    end
    
    xs = [xs; oldSet(i, 1)];
    ys = [ys; oldSet(i, 2)];
    
    oldSet(i, :)
    found
    
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

scatter(xs, ys, [], colors);

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

