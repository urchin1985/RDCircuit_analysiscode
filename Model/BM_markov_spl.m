% initialize markov transition probs
p0 = [.98 .99]; %[explore/roam exploit/dwell]
sto = 1; sth = sto;
loc0 = [0 0]; Xh = [];
inp = 0; pprv = p0;
tn = 2000;

for ti = 1:tn
    % compute movement


% update location

    
% compute sensory input given recent movement
    
    [state,pnew] = bmkvfun(inp,pprv,sto);

sto = state;
sth = [sth state];
pprv = pnew;
end

figure(36);clf;hold all
plot(sth);ylim([0 1.2])
pnew