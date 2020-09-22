% initialize markov transition probs
tn = 2000;
p0 = [.98 .8]; %[explore/roam exploit/dwell]
sto = 1; state = sto; sth = [];
loc0 = [0 0]; loc = loc0;
inp = .01; iph = [];
ha = 2*(rand-.5)*pi; hp1 = .5;
han = normrnd(0,13,[1 tn]); han = smooth(han,51); % noise in orientation
kg = 1; % klinotaxis gain
gd = 3; % sensory input gain
pprv = p0; stpp = sto;
dl = 15; % # delayed timepts

for ti = 2:tn
    % compute orientation
    % update locomotory state and calculate location
    if state
        % first determine direction of motion
        dha = hp1*(abs(ha(ti-1))); % klinotaxis
        ha(ti) = (abs(ha(ti-1))-dha)*sign(ha(ti-1))+han(ti);
    elseif sum(stpp(1))
        dha = hp1*(abs(ha(ti-1))); % klinotaxis
        ha(ti) = (abs(ha(ti-1))-dha)*sign(ha(ti-1))+han(ti);
    else
        ha(ti) = 2*(rand-.5)*pi;
    end
    
    % execute movement
    if state
        loc(ti,:) = loc(ti-1,:)+[cos(ha(ti-1)) sin(ha(ti-1))]*kg;
    else
        loc(ti,:) = loc(ti-1,:)+[cos(ha(ti-1)) sin(ha(ti-1))]*kg/6;
    end
    
    % compute sensory input given recent movement
    inp = max(0,gd*(loc(ti,1)-loc(ti-1,1)));
%     inp = 2;
sto = state;
stpp = [stpp sto]; 
if length(stpp)>dl
stpp = stpp((end-dl):end);
end

    [state,pnew] = bmkvfun(inp,pprv,sto);
    
    sth(ti) = state;
    iph(ti) = inp;
    pprv = pnew;
end
%%
figure(36+3*(inp~=2));clf;hold all
subplot(5,1,1)
plot(sth); ylim([0 1.2])
ylabel('R-D state'); xlabel('time a.u.')
xlim([1 tn])
subplot(5,1,2:5); hold all
plot(loc(:,1),loc(:,2),'.-')
plot(loc(sth<1,1),loc(sth<1,2),'r.')
plot(loc(1,1),loc(1,2),'go','markerfacecolor','g')
plot(loc(end,1),loc(end,2),'ro','markerfacecolor','r')
xlabel('gradient direction'); ylabel('orthogonal direction')
sum(sth)