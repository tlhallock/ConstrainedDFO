function assert_close(x, y, r)

if nargin < 3
    r = abs(x);
end

if abs(r) < 1e-12
    r = 1;
end

if norm(x-y) / r > 1e-8
    ' points failed to be close'
    throw 1
end

