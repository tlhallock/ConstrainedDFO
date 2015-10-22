
functions;



dim     =  1;
d       =  2;
npoints =  3;


%dim     =  2;
%d       =  2;
%npoints =  6;



%dim     =  2;
%d       =  3;
%npoints = 10;

initialPoints = rand(npoints, dim);




initialPoints(3,:) = initialPoints(5,:);

initialPoints


[poisedSet lagrange] = poise(initialPoints, d, 1e-6);

plot(t, polyval(lagrange(1,:)' , t), t, polyval(lagrange(2,:)', t), t, polyval(lagrange(3,:)', t))




t = linspace(min(poisedSet), max(poisedSet), 100);

polys = fliplr(lagrange');


hold on
for i = 1:size(polys, 2)
     plot (t, polyval(polys(i,:), t))
end

hold off
