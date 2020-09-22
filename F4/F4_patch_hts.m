setsavpath

gtype = {'wt','aiaunc','pdfr1','tax4','tph1'};
svon = 0;
%% plot loc hist progression across genotypes
pclr = {.2*[1 1 1],.5*[0 1 0],[0 0 1],[.64 .08 .18],[.85 .5 0]};
fid = 120;
for gi = 1:length(gtype)
    curdf = [bpath gtype{gi} '_fuldata.mat'];
    load(curdf)
    
    distmat_b
    
    dff = [dtx;xgt.d2b;xgt.d2a];
    %
    dts = [.1 20 40 60]; tn = length(dts);
    dfd = cell(1,tn);
    for di = 1:tn
        dfd{di} = dff(:,dts(di)*180);
    end
    
    %%
    plt = [15 50 85];
    %     plcs = [prctile(dfd{1},plt);prctile(dfd{2},plt);prctile(dfd{3},plt)];
    
    dp = 2; aph = .7; bcl = pclr{gi}; ecl = []; kcl = bcl;
    dx = 100; xc = -1500:dx:1500; xlm = [-1000 1500];
    
    % plot hist progression
    figure(fid+gi-1); clf;hold all
    for ti = 1:tn
        subplot(tn,1,ti)
        dat = dfd{ti};
        [kg,kgx] = kshistgen(dat,xc,dx,bcl,ecl,kcl,aph,dp);
        hold all
        dlm = prctile(dat,plt([1 3]));
        plot([0 0],[0 .5],'r:','linewidth',1.5)
        plot(dlm(1)*ones(1,2),[0 .5],'m','linewidth',1.5)
        plot(dlm(2)*ones(1,2),[0 .5],'m','linewidth',1.5)
        set(gca,'xlim',xlm,'ylim',[0 .23],...
            'ytick',0:.1:.3,'yticklabel','','xticklabel','','tickdir','out','ticklength',.015*ones(1,2))
        box off
    end
    set(gcf,'outerposition',[130+(gi-1)*200 482 240 430])
end

%% save plots
if svon
    for gi = 1:length(gtype)
        figure(fid+gi-1); hold all
        
        savname = [gtype{gi} '_patloc_hists'];
        saveas(gcf,[savpath2 savname '.tif'])
        saveas(gcf,[savpath2 savname '.fig'])
        saveas(gcf,[savpath2 savname '.eps'],'epsc')
    end
    
end