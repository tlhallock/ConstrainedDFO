function [results] = algorithm(params)

results = algo_results_create();
s = algo_state_create(params);

s.vals = mock_structure_add(s.vals, params.x0', params.f(params.x0));
results.fvals = results.fvals + 1;
fullyLinear = false;

for step = 1:params.max_iters
    % Note: this will improve the set if the set is not poised AT ALL
    [s, results, improved] = algo_create_model(params, s, results, false);
    fullyLinear = fullyLinear || improved;
    
    %    test_interpolation(params, s);
    
%            && s.radius > params.mu * norm(s.g)
    while norm(s.g) < params.eps_c ...
            && (~fullyLinear || s.radius > params.mu * norm(s.g))
        % Could have something about s.radius < params.tolerance?
        s.radius = min(max(...
            s.radius * params.omega,...
            params.beta * norm(s.g)), s.radius);
        [s, results, fullyLinear] = algo_create_model(params, s, results, true);
    end
    
    % open ball, closed ball
    %  inter = @(x)(poly_eval(model, (x - s.model_center) / s.model_radius));
    %  [sqpIterate, sqpObj, sqpInfo, sqpIter, sqpNf, sqpLambda] = ...
    %      sqp(s.model_center, inter, [], [],
    %      s.xmin - s.radius,
    %      s.xmin + s.radius);
    extrema = params.interp_extrema(s.model_coeff);
    
    currentX   = s.model_center;
    currentVal = mock_structure_get(s.vals, currentX');
    
    newX = extrema.minX * s.radius + s.model_center;
    newVal = params.f(newX);
    
    results.fvals = results.fvals + 1;
    s.vals = mock_structure_add(s.vals, newX', newVal);
    
    
    rho = (currentVal - newVal) / ...
        (s.model((currentX - s.model_center) / s.radius) - extrema.minVal);
    
    plot_state(s, strcat('imgs/newpoint_', int2str(results.iterations)), newX);
    
    if rho >= params.eta1
        s.radius = min(params.gamma_inc * s.radius, params.radius_max);
        s.model_center = newX;
        fullyLinear = false;
    else
        if fullyLinear
            if rho >= params.eta0 % I don't like this, y not check take any improvement better than eta1, we are going to improve the model anyway... (Move this if statement outside the fully linear check.)
                s.model_center = newX;
            end
            s.radius = params.gamma * s.radius;
            fullyLinear = false;
        else
            [s, results, fullyLinear] = algo_create_model(params, s, results, true);
        end
    end
    
    %    s = algo_clean_poised_set(s);
    results.iterations = results.iterations + 1;
end

end



