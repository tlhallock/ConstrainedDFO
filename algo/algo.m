function [results] = algo(params)

results = algo_create_results();
s = algo_create_state(params);

for step = 1:params.max_iters
    % Create the model
    [s, fail] = algo_update_model(params, s);
    if fail
        % If not poised, improve the model
        s = algo_model_improve(params, s);
    end
    
    %    test_interpolation(params, s);
    while norm(s.g) < params.eps_c ...
            && (~s.fullyLinear || s.radius > params.mu * norm(s.g))
        % Could have something about s.radius < params.tolerance?
        s.radius = min(...
            max(s.radius * params.omega, params.beta * norm(s.g)), ...
            s.radius);
        s = algo_model_improve(params, s);
        s.plot_number = plot_state(s, params);
        
        s.radius
        
        results = algo_update_results(s, results);
        
        if s.radius < params.tolerance
           return 
        end
    end
    extrema = params.interp_extrema(s.model_coeff);
    
    currentX   = s.model_center;
    currentVal = mock_structure_get(s.vals, currentX');
    
    newX = unshift_set(extrema.minX', s.model_center', s.radius)';
    [s.vals, newVal] = mock_structure_add(s.vals, newX', s.f, s.radius);
    newVal = newVal';
    
    results.xs = [results.xs; newX'];
    
    rho = (currentVal - newVal) / ...
        (s.model((currentX - s.model_center) / s.radius) - extrema.minVal);
    
    rho
    
    s.plot_number = plot_state(s, params, newX);
    
    if rho >= params.eta1
        s.radius = min(params.gamma_inc * s.radius, params.radius_max);
        s.model_center = newX;
        s.fullyLinear = false;
    else
        if s.fullyLinear
            % I don't like this:
            % y not check take any improvement better than eta1, we are going to improve the model anyway... 
            % (Move this if statement outside the fully linear check.)
            if rho >= params.eta0 
                s.model_center = newX;
            end
            s.radius = params.gamma * s.radius;
            s.fullyLinear = false;
        else
            s = algo_model_improve(params, s);
        end
    end
    
    %    s = algo_clean_poised_set(s);
    results = algo_update_results(s, results);
end

end

    
    % open ball, closed ball
    %  inter = @(x)(poly_eval(model, (x - s.model_center) / s.model_radius));
    %  [sqpIterate, sqpObj, sqpInfo, sqpIter, sqpNf, sqpLambda] = ...
    %      sqp(s.model_center, inter, [], [],
    %      s.xmin - s.radius,
    %      s.xmin + s.radius);


