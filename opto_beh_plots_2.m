%% generate official plots
plclr = getstateclr; plclr = [plclr;.6*ones(1,3)];
fid = 46; pth = .0786;

for gi = 1:length(gztype)
    figure(fid+round(gi/2)-1);
    set(gcf,'outerposition',[138+round(gi/2)*200 584 214 308])
    if mod(gi,2)
        clf; hold all
        pclr = plclr(3,:);
    else
        hold all
        pclr = plclr(1,:);
    end
    
    cdt = gc(gi).rp;
    % 1. average speed traces
    plot_bci([],cdt.rci,cdt.rmn,pclr,[],[])
    yrn = get(gca,'ylim');
    set(gca,'xlim',[0 size(opmat,2)])
       
    if mod(gi,2)
        pclr = plclr(3,:);
    else
        hold all
        pclr = plclr(2,:);
    end
    plot_bci([],cdt.dci,cdt.dmn,pclr,[],[])
    set(gca,'ylim',[0.005 0.13])
    yrn = get(gca,'ylim');
    plot([15 75;15 75]*3,[yrn' yrn'],'k:','linewidth',1.5)
    set(gca,'xlim',[0 size(cdt.rmn,2)],'ytick',.02:.04:.12)
    
    %% 2. bootstrapped histograms
    rdt1 = cdt.rmat(:,57); rdt2 = cdt.rmat(:,105);
    ddt1 = cdt.dmat(:,105); ddt2 = cdt.dmat(:,165);
    figure(fid+6+round(gi/2)-1);
    if mod(gi,2)
        clf; hold all; pclr = plclr(3,:);
    else
        pclr = plclr(1,:);
    end
    subplot 221; hold all
    [f,xi] = ksdensity(rdt1);
    plot(xi,f,'color',pclr)
    xlim([0 .2])
    subplot 222; hold all
    [f,xi] = ksdensity(rdt2);
    plot(xi,f,'color',pclr)
        xlim([0 .2])

        if mod(gi,2)
        clf; hold all; pclr = plclr(3,:);
    else
        pclr = plclr(2,:);
    end
    subplot 223; hold all
    [f,xi] = ksdensity(ddt1);
    plot(xi,f,'color',pclr)
        xlim([0 .15])

    subplot 224; hold all
    [f,xi] = ksdensity(ddt2);
    plot(xi,f,'color',pclr)
        xlim([0 .15])
end