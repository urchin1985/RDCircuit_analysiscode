
% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wt','tph1n','mod1','pdfr1','pdfracy1','tph1pdfr1'};
svon = 0;
%% NSM vs AVB activitiy histogram
clc
btn = 100; fiid = 73;
fgl = length(fgtype); ocmat = cell(1,fgl);
clrs = getstateclr;
cx = -.0125:.005:.115;

figure(fiid);clf;hold all
for fgi = 1:length(fgtype)
    gtype = fgtype{fgi};
    load([savpath gtype '_alldata.mat'])
    if strcmp(gtype,'wt')
        fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
    else
        fids = find(Fdx>0);
    end
    
    cdata = Cdat(fids,:);
    cdata(cdata==0) = nan;
    % cdata = zscore(cdata,[],1);
    fdata = Fdx(fids);
    vdata = Vdat(fids)/20000;
    bdata = Bst2(fids);
    %     vlx = vax_clust(fids);
    cln = size(cdata,1);
    
    pid = vdata>=-.005;
    ndt = cdata(pid,1); pdt = abs(vdata(pid)); bdt = bdata(pid);
    
    if fgi==1
        subplot(fgl+1,1,1);
        pd1 = pdt(bdt==1);
        [kg1,kgx1,hgx1,hgy1] = kfhist(pd1,cx,[],clrs(1,:));
        pd2 = pdt(bdt==2);
        [kg2,kgx2,hgx2,hgy2] = kfhist(pd2,cx,[],clrs(2,:));
        cla;hold all
        bar(hgx1,hgy1,'facecolor',clrs(1,:),...
            'edgecolor','none');alpha(.5);
        bar(hgx2,hgy2,'facecolor',clrs(2,:),...
            'edgecolor','none');alpha(.5);
        plot(kgx1,kg1,'color',clrs(1,:),'linewidth',1.5);
        plot(kgx2,kg2,'color',clrs(2,:),'linewidth',1.5);
            xlim(cx([1 end-1]))
plotstandard;
set(gca,'xtick',0:.025:.1,'ylim',[0 .3])
    end
    
    subplot(fgl+1,1,fgi+1);cla;hold all
    [kg,kgx] = kfhist(pdt,cx,[],[0 .3 0]); alpha(.5)
    xlim(cx([1 end-1]))
plotstandard;
set(gca,'xtick',0:.025:.1,'ylim',[0 .2])
end
%%
figure(fiid)
set(gcf,'outerposition',[-10.2000  618.6000  761.6000  170.4000])
if svon
    savname = ['wtmt_nmab_coop'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
    save([savpath savname(1:(end-1)) '.mat'],'ocmat','oco','omn','oci',...
        'fdrp','rp','fgtype')
end
