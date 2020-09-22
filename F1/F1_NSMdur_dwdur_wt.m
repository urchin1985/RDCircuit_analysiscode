cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wt','tph1','mod1','pdfr1','tph1pdfr1'};
vadur = cell(1,4); ndur = vadur;
cid = 3; % 3~NSM high periods
vid = 1;
%% extract transition period data and project onto PC space as defined by wild type
vadur = cell(1,4); ndur = vadur;
ci = 1;
gtype = 'wt';
load([savpath gtype '_alldata_1019.mat'])
load([savpath gtype '_NSM_triggstat_1019.mat'])
if strcmp(gtype,'wt')
    fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
else
    fids = find(Fdx>0);
end

extract_ndur_vdur
%
siz = 55; opa = .5; clr = [0 0 .5];
figure(35);clf;hold all
plot([0 2400],[0 2400],'k:','linewidth',1)
transparentScatter(ndur{1}',vadur{1}',siz,opa,clr);
plotstandard
axis equal
set(gca,'yticklabel','','ylim',[-60 1600],'xlim',[-60 1600],...
    'ytick',0:600:2400,'xtick',0:600:2400)
set(gcf,'outerposition',[481 597 197 245])

% save data for direct plotting
if svon
    savname = ['wt_nsmdwdur_scatter'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
    save([savpath savname '.mat'],'ndur','vadur','fgtype')
end

