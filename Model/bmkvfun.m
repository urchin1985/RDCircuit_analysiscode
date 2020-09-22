function [state,pnew] = bmkvfun(inp,pprv,sto)
% update transition probs based on input, then draw random number to
% determine state at next time step
p11 = pprv(1); % roam self-trans prob
p22 = pprv(2); % dwell self-trans prob

% specify params
a1 = 5; a2 = 1; % 5-1
ki1 = 1; ki2 = 3;
p11n = 1/(1+exp(-a1*(inp-ki1))); % roaming prob increase with increasing input
p22n = 1/(1+exp(a2*(inp-ki2))); % dwelling prob also increase but more gradually

pr = rand(1);

switch sto
    case 0 % dwelling
        state = pr>p22n;
    case 1 % roaming
        state = pr<p11n;
end

pnew = [p11n,p22n];