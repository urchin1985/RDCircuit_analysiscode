% initialize markov transition probs
tn = 2000;
p0 = [.98 .8]; %[explore/roam exploit/dwell]
sto = 1; state = sto; sth = [];
loc0 = [0 0]; loc = loc0;
inp = .01; iph = [];
ha = 2*(rand-.5)*pi; hp1 = .5;
han = normrnd(0,6,[1 tn]); han = smooth(han,51); % noise in orientation
kg = 3; % klinotaxis gain
gd = 3; % sensory input gain
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
        loc(ti,:) = loc(ti-1,:)+[cos(ha(ti-1)) sin(ha(ti-1))]*.5;
    end
    
    % compute sensory input given recent movement
    inp = max(0,gd*(loc(ti,1)-loc(ti-1,1)));
%     inp = 2;
    
    [state,pnew] = bmkvfun(inp,pprv,sto);
    
    sto = state;
    sth(ti) = state;
    iph(ti) = inp;
    pprv = pnew;
end
%%
yf = 490;
cmap = cmap_gen({ones(1,3),[1 .9 0.5]},0);
figure(38);clf;hold all
imagesc(ones(1000,1)*[zeros(1,1200) 0:2300]);
colormap(cmap)

hold all
plot(loc(sth>.1,1),loc(sth>.1,2)+yf,'.','color',[.97 .3 0])
plot(loc(sth<1,1),loc(sth<1,2)+yf,'b.','markersize',11)

set(gca,'xdir','reverse','xticklabel','','yticklabel','')
xlim([-100 3500]);ylim([0 1000])
% axis equal

savpath = ['C:\Users\Ni Ji\Dropbox (MIT)\ImageSeg_GUI\MNI segmentation\' ...
'MNI turbotrack (dropbox)\Figures\Model\Plots\'];

savname = ['BMucpltraj3'];
saveas(gcf,[savpath savname '.tif'])
saveas(gcf,[savpath savname '.fig'])