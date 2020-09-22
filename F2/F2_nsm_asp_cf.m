% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wt','tph1','mod1','pdfr1','tph1pdfr1','tph1i'};
svon = 0;
%% NSM vs speed activitiy histogram
clc
cclrs = [0 0 .3;.9 .7 .2;.5 .1 .56];
ln = 3;
fi1 = 30; fi2 = 40;
ap = .025;
figure(fi2);clf;hold all

fpi = 1; clear xset yset
for fgi = [1 4]
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
    vlx = vax_clust(fids);
    
    
    % idx = vdata>-10&(cdata(:,4)>0)&(cdata(:,1)>0); % vdata>10&(cdata(:,4)>0.01);
       idx = (bdata(:)==2)&(vdata>0);
        
        xset{fpi} = cdata(idx,1);
        yset{fpi} = (vdata(idx))/20000;

    
    if fgi == 1
        xth = prctile(cdata(:,1),80);
        yth = prctile(vdata(idx),80)/20000;
    end
    
    if fgi==1
        ap = .035;
    else
        ap = 0.1;
    end
    figure(fi2); hold all
        scatter(cdata(idx,1),(vdata(idx))/20000,15,cclrs(fpi,:),'filled','markerfacealpha',ap);caxis([0 .1]);
    fpi = fpi+1;
end
plot([xth xth;-1 2]',[-1 2;yth yth]','k:','linewidth',1.5)
xlim([-.15 1.2]);ylim([-.005 .1])
axis square
plotstandard
set(gca,'xtick',0:.5:1,'ytick',0:.05:1,'yticklabel','')
set(gcf,'outerposition',[62 484 172 229])

figure(fi1);clf; hold all
xh = make2dschist(xset,yset,cclrs,[.05,.005]);
xh(1).YLim = [-.005 .12];
xh(1).XLim = [-.15 1.2];
axis square

if svon
    figure(fi1)
    savname = 'wtmt_nsm_asp_sch';
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
    figure(fi2)
    savname = 'wtmt_nsm_asp_sct';
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
end