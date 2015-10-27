function num = test(n, k)

num = 0;
if (n == 0 || k == 0)
    return;
end

if (n == 1)
    num = 1;
    return;
end

for i = 0:k
    num = num + test(n-1, k - i);
end

end