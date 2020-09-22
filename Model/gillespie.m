function first_matlab_simulation(npoints,n)

% n = 0; %initial state
t(1) = 0;
state(1) = n;

for k = 2:npoints
    r1 = (12.5+0.02*n^2)/(1+0.0001*n^2); % creation rate
    r2 = n; % degradation rate
    
    % draw random number
    t1 = -log(rand(1,1))./r1;
    t2 = -log(rand(1,1))./r2;
    
    time = min(t1,t2); % inter-reaction time
    
    if t1 < t2
        n = n+1;
    elseif t1 > t2
        n = n-1;
    end
    
    t(k) = time;
    state(k) = n;
end

t = cumsum(t);

stairs(t,state)