function [kg,kgx] = kshistgen(dat,xr,dx,bcl,ecl,kcl,aph,dp)
hx = xr(1):dx:xr(end);
dat = dat(~isnan(dat(:)));

if dp>0
    if dp>1
        figure
        hg = histogram(dat(:),hx);
        hgy = hg.Values/sum(hg.Values);
        close
        if isempty(ecl); ecl = 'none'; end
        if isempty(aph); aph = 0.5; end
        bar(hx(1:(end-1)),hgy,'facecolor',bcl,'edgecolor',ecl);
        alpha(aph)
    end
%     o
    hold all
    [kg,kgx] = ksdensity(dat(:)); kg = kg*dx;
    plot(kgx,kg,'color',kcl,'linewidth',1.5);
end