% stationary params
tn = 2000;
p0 = [.98 .8]; %[explore/roam exploit/dwell]
sto = 1; state = sto; sth = [];
loc0 = [0 0]; loc = loc0;
inp = .01; iph = [];
ha = 2*(rand-.5)*pi; hp1 = .5;
han = normrnd(0,6,[1 tn]); han = smooth(han,51); % noise in orientation
kg = 3; % klinotaxis gain
gd = 3; % sensory input gain
bprm.p0 = p0; bprm.ha = ha; bprm.hp1 = hp1;
bprm.han = han; bprm.kg = kg; bprm.gd = gd;
pprv = p0;
% % kg = 2; % klinotaxis gain
% % gd = 5; % sensory input gain
%%
mlc = []; inph = [];

figure(36);clf;hold all
for mi = 1:100
% initialize model
sto = 1; state = sto;
loc0 = [0 0]; loc = loc0;
inp = .01; iph = [];
ha = 2*(rand-.5)*pi; hp1 = .5;
han = normrnd(0,6,[1 tn]); han = smooth(han,51); % noise in orientation

pprv = p0;

for ti = 2:tn
    % compute orientation
    % update locomotory state and calculate location
    if state % movement only occurs during roaming
        % first determine direction of motion
        if sto
            dha = hp1*(abs(ha(ti-1))); % klinotaxis
            ha(ti) = (abs(ha(ti-1))-dha)*sign(ha(ti-1))+han(ti);
        else
            ha(ti) = 2*(rand-.5)*pi;
        end
    else
        ha(ti) = 2*(rand-.5)*pi;
    end
    
    % execute movement
    if state
        loc(ti,:) = loc(ti-1,:)+[cos(ha(ti-1)) sin(ha(ti-1))]*kg;
    else
        loc(ti,:) = loc(ti-1,:)+[cos(ha(ti-1)) sin(ha(ti-1))]*.1;
    end
    
    % compute sensory input given recent movement
    inp = max(0,gd*(loc(ti,1)-loc(ti-1,1)));
    inph = [inph inp];
%     inp = 2;
    
    [state,pnew] = bmkvfun(inp,pprv,sto);
    
    sto = state;
    sth(ti) = state;
    iph(ti) = inp;
    pprv = pnew;
end
%%
% % subplot(5,1,1)
% % plot(sth); ylim([0 1.2])
% % ylabel('R-D state'); xlabel('time a.u.')
% % xlim([1 tn])
subplot(5,1,1:4); hold all
plot(loc(:,1),loc(:,2),'-','color',.5*ones(1,3))
mlc = [mlc;loc(end,:)];
end
plot(mlc(:,1),mlc(:,2),'r.')
plot(0,0,'go','markerfacecolor','g')
xlabel('gradient direction'); ylabel('orthogonal direction')
%%
subplot(5,1,5);cla;
hist(mlc(:,1),0:100:3000)

% save('BMpoploc_ucp.mat','loc','mlc','bprm')