strd = 5; wl = 120;

% calculate xcorr
xstr = 1:strd:(tl-wl/2);
wn = length(xstr);
wpr = floor((tpre-3*wl/4)/strd);
% if tl-xstr(end)<(wl/4)
%     xstr(end) = tl;
% else
%     xstr = [xstr tl];
%     wn = wn+1;
% end

%
xcmat = cell(1,wn);
for tri = 1:tn
    for wi = 1:wn
        dwin = xstr(wi)+(0:(wl-1));
        dwin = min(dwin,tl); dwin = unique(dwin);
        tx = Tm{c1}(tri,dwin); ty = Tm{c2}(tri,dwin);
        tx = tx-prctile(tx,5);
        if c1==1
            if wi>=wpr||(max(tx)>.015&&max(tx)<.1)
                [xcf,lags] = crosscorr(tx,ty,30);
                xcmat{wi} = [xcmat{wi}; xcf];
            end
        else
            [xcf,lags] = crosscorr(tx,ty,30);
            xcmat{wi} = [xcmat{wi}; xcf];
        end
    end
end
%
% xcm = nan(wn,21);
clear xci xcm xse
for wi = 1:wn
    if ~isempty(xcmat{wi})
        wout = cal_matmean(xcmat{wi},1,0);
        %     xcm(wi,:) = wout.mean;
        [xmm,xmi] = max(wout.mean);
        xcm(wi) = xmm;
        %     xci(:,wi) = wout.ci(:,xmi);
        xse(wi) = wout.se(xmi);
    else
        xcm(wi) = nan;
        %     xci(:,wi) = wout.ci(:,xmi);
        xse(wi) = nan;
    end
end

hold all
% waterfall(xcm)
plot_bci((xstr+wl/2)/2,xse,xcm,xclr,[],[])

xnon = (xstr(wpr+1)+wl/2)/2;
plot(xnon*[1 1],[-1 1],'k:','linewidth',1.5)

xlm = xnon+[-50 60];
xlim(xlm);
plot(xlm,[0 0],'k:','linewidth',1.5)