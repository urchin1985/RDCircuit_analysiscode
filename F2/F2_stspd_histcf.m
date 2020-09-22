cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wtf','tph1','mod1','pdfr1','tph1pdfr1','pdfracy1'};
cid = 3; % 3~NSM high periods
bid = 3;
svon = 0;
%%
% load([savpath 'wt_mt_bvbdstat.mat'],'bvful','fgtype')

fi1 = 40;
eclrs = [0 0 .3;.9 .7 .2;.5 .1 .56];
clrs = getstateclr;
fa = [.6 .6 .6];
ec = {'k','k','k'};
hx = 0:.006:.06;

figure(fi1+1);clf; hold all
fpi = 1;
for fgi = [1 4 6] %length(fgtype)
    
    gtype = fgtype{fgi};
    load([savpath gtype '_alldata.mat'])
    load([savpath gtype '_NSM_triggstat.mat'])
    if strcmp(gtype,'wt')
        fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
    else
        fids = find(Fdx>0);
    end
    
    cdata = Cdat(fids,:);
    cdata(cdata==0) = nan;
    % cdata = zscore(cdata,[],1);
    fdata = Fdx(fids);
    vdata = Vdat(fids);
    bdata = Bst(fids);
    nlx = nsm_clust(fids);
    %     vlx = vax_clust(fids);
    subplot(3,1,fpi); hold all
    
    if fpi>1
        plot(wb1m*[1 1],[0 1],':','color',clrs(end,:),'linewidth',1)
        plot(wb2m*[1 1],[0 1],':','color',clrs(1,:),'linewidth',1)
        
    end
    
    by1 = (bvful(fgi).st(1).bvm)/20000;
    by2 = (bvful(fgi).st(2).bvm)/20000;
    % by1 = vdata(bdata==1)/20000; by1(by1<=0) = [];
    % by2 = vdata(bdata==2)/20000; by2(by2<=0) = [];
    by1m = nanmedian(by1);
    by2m = nanmedian(by2);
    
    if fpi == 1
       wb1m = by1m; wb2m = by2m;  
    end
    
    plot(by1m*[1 1],[0 1],'color',clrs(end,:),'linewidth',1)
    plot(by2m*[1 1],[0 1],'color',clrs(1,:),'linewidth',1)
    
    hd1 = histogram(by1,hx,'edgecolor',ec{fpi},'facecolor',clrs(end,:),'facealpha',fa(fpi));
    hd1.BinCounts = hd1.BinCounts/sum(hd1.BinCounts);
    
    hd2 = histogram(by2,hx,'edgecolor',ec{fpi},'facecolor',clrs(1,:),'facealpha',fa(fpi));
    hd2.BinCounts = hd2.BinCounts/sum(hd2.BinCounts);
    
    
    ylim([0 .5])
    if fpi==2
        ylim([0 .6])
    end
    plotstandard
    set(gca,'ytick',0:.25:.5,'yticklabel','','xtick',0:.03:.06)
    
    fpi = fpi+1;
end
set(gcf,'outerposition',[87 350 129 345])

if svon
    savname = ['wt_' fgtype{fgi} '_bstspd'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
end