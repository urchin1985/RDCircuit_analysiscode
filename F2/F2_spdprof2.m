
% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wtf','tph1','mod1','pdfr1','pdfracy1','tph1pdfr1'};
svon = 0;
%% NSM vs AVB activitiy histogram
clc
btn = 100; fiid = 73;
fgl = length(fgtype); ocmat = cell(1,fgl);
clrs = getstateclr;
cx = -.0125:.005:.105;

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
        if fgi==1; bdata = 2-bdata; end
    cln = size(cdata,1);
    
    pid = vdata>=-.005;
    ndt = cdata(pid,1); pdt = (vdata(pid)); bdt = bdata(pid);
    
    subplot(fgl,2,2*(fgi-1)+1);cla;hold all
    pd1 = pdt(bdt==1);
    [kg1,kgx1,hgx1,hgy1] = kfhist(pd1,cx,[],clrs(2,:));
    xlim(cx([1 end]))
    plotstandard;
    set(gca,'xtick',0:.025:.1,'ylim',[0 .3])
    
    subplot(fgl,2,2*(fgi));cla;hold all
    pd2 = pdt(bdt==2);
    [kg2,kgx2,hgx2,hgy2] = kfhist(pd2,cx,[],clrs(1,:));
    
    xlim(cx([1 end]))
    plotstandard;
    set(gca,'xtick',0:.025:.1,'ylim',[0 .3])
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
