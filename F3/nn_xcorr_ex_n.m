strd = 5; wl = 60; % 150

% calculate xcorr
% xstr = 1:strd:(tl-wl/2);
xstr = [400 540 620];
wn = length(xstr);
wpr = floor((tpre-3*wl/4)/strd);

%
xcmat = cell(1,wn);
for tri = 1:tn
    for wi = 1:wn
        dwin = xstr(wi)+(0:(wl-1));
        dwin = min(dwin,tl); dwin = unique(dwin);
        tx = Tm{c1}(tri,dwin); ty = Tm{c2}(tri,dwin);
        tx = tx-prctile(tx,5);
        if c1==1
%             if (wi>1&&max(tx)>.3)||(wi<2&&max(tx)>.015&&max(tx)<.1)%wi>=wpr||(max(tx)>.015&&max(tx)<.1)
                [xcf,lags] = crosscorr(tx,ty,cw);
                xcmat{wi} = [xcmat{wi}; xcf];
%             end
        else
            [xcf,lags] = crosscorr(tx,ty,cw);
            xcmat{wi} = [xcmat{wi}; xcf];
        end
    end
%     figure(15);clf;hold all
%     subplot 121;plot(lags,xcf)
%     subplot 122;hold all;plot(tx);plot(ty)
%     [x,y] = ginput(1);
end
%
% xcm = nan(wn,21);
clear xci xcm xse
for wi = 1:wn
    if ~isempty(xcmat{wi})
        wout = cal_matmean(xcmat{wi},1,0);
        xcm(wi,:) = wout.mean;
        xmx = [wout.mean+wout.se;wout.mean-wout.se];
        xmo = max(abs(wout.mean),[],1);
        [~,xmi] = max(xmo);
        xse(wi,:) = wout.se;
        subplot(1,wn,wi); cla;hold all
        plot([-cw cw],[0 0],'k')
        plot([0 0],[-1 1],'k:')
        plot_bci(lags,wout.se,wout.mean,xclr,[],[])
        if c1~=9
        text(lags(xmi),wout.se(xmi)+wout.mean(xmi)+.05,'*','fontsize',18,'color','r')
        else
        text(lags(xmi),-wout.se(xmi)+wout.mean(xmi)-.12,'*','fontsize',18,'color','r')            
        end
        plotstandard
        set(gca,'xtick',[-cw:15:cw],'xlim',[-cw cw],...
            'ytick',-.5:.25:.7,'ylim',[-.25 .75],'yticklabel','')
        if c1 == 9; ylim([-.6 .4]); end
    else
        xcm(wi) = nan;
        xse(wi) = nan;
    end
end
