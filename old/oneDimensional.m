




dim     =  1;
d       =  2;
npoints =  3;


t = linspace(-50, 40, 1000);
ceos = 5 * rand(1, 5);
f=@(x) (polyval([1 50 0 -100 0], x));


plot(t, f(t));


%initialPoints(3,:) = initialPoints(5,:);

plotradius = .2;


x = 0;
radius = 1;
initialPoints = x + radius * (2 * rand(npoints, dim) - 1);



for i = 1:length(initialPoints)
	vals(i) = f(initialPoints(i));
end


poisedSet = initialPoints;
vals = zeros(1, length(initialPoints));
for i = 1:length(poisedSet)
	  vals(i) = f(poisedSet(i));
end
[_ index] = min(vals);
iterate = poisedSet(index);


for step = 1:100
	% Get the poised set, and the lagrange polynomials for this region

	shiftedSet = poisedSet;
	for i=1:size(shiftedSet, 1);
		shiftedSet(i) = (poisedSet(i) - iterate) / radius;
	end
	     
	[shiftedSet lagrange] = poise(shiftedSet, d, 1e-6);

	for i = 1:size(shiftedSet, 1)
		  poisedSet(i) = shiftedSet(i) * radius + iterate;
	end


	% Get the values of the function at this set
	vals = zeros(1, length(poisedSet));
	for i = 1:length(poisedSet)
		  vals(i) = f(poisedSet(i));
	end


	b = radius + [iterate -iterate];
	A = [1 -1];
	
	polys  = fliplr(lagrange');
	coeffs = sum(diag(vals) * polys);
	inter  = @(x)(polyval(coeffs, (x - iterate) / radius));


	% Is this right?
	lambda = 0;
	for i = 1:size(polys, 2)
		lambda=max(lambda, abs(sqp(iterate, @(x)(polyval(polys(i, :), (x - iterate) / radius)), [], [], iterate - radius, iterate + radius)));
	end


	[sqpIterate, sqpObj, sqpInfo, sqpIter, sqpNf, sqpLambda] = sqp(iterate, inter, [], [], iterate - radius, iterate + radius);
	

	% Plot them
	hold on
%	t = linspace(min(poisedSet) - plotradius*abs(min(poisedSet)), max(poisedSet) + plotradius * abs(max(poisedSet)), 100);
	t = linspace(iterate - radius, iterate + radius, 100);


%	t = linspace(-1, 1, 100);

	minY = 0;
	maxY = 0;

	for i = 1:size(polys, 2)
		lvals = polyval(polys(i,:), (t-iterate) / radius);
		ivals = vals(i) * lvals;

		minY = min([ minY ivals]);
		maxY = max([ maxY ivals]);

		
		plot (t, ivals, 'Color', [ 0 0 1 ]);
	end
	plot(t, f(t), 'Color', [ 1 0 0 ]);
	plot(t, inter(t), 'Color', [0 1 0]);


	for i = 1:length(poisedSet)
		plot ( [ poisedSet(i), poisedSet(i)] , [minY, maxY], 'Color', [ 1 1 0 ])
	end

	plot ( [sqpIterate, sqpIterate] , [minY, maxY], 'Color', [ 0 0 0 ])

	
	hold off


	newVal = f(sqpIterate);

	rho = (vals(index) - newVal) / (vals(index) - sqpIterate)

	
	[_ index] = min(vals);
	iterate = poisedSet(index);
end


plot(t, polyval(lagrange(1,:)' , t), t, polyval(lagrange(2,:)', t), t, polyval(lagrange(3,:)', t))





     
