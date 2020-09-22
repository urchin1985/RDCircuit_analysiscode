clear
setsavpath
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

%%
gtype = 'wt';
load([savpath gtype '_alldata.mat'])
% fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
fids = find(Fdx>0);
cdata = Cdat(fids,:);
nlab = nsm_clust(fids);
vlab = vax_clust(fids);
cvals = nlab;
cnum = size(cdata,2);

load([savpath gtype '_NSM_triggstat.mat'])
%% plot triggered average for NSM and axial speed
smw = 45;
prng = 360:840; bn = 500;
tdat = (TD_on(1).vals(:,prng));
nout = cal_matmean(tdat,1,1);
nm = slidingmean([],nout.mean,smw,-1);
nlo = slidingmean([],nout.ci(1,:),smw,-1);
nhi = slidingmean([],nout.ci(2,:),smw,-1);

% % tdat = (TD_on(4).vals(:,prng));
% % bout = cal_matmean(tdat,1,1);
% % bm = slidingmean([],bout.mean,smw,-1);
% % blo = slidingmean([],bout.ci(1,:),smw,-1);
% % bhi = slidingmean([],bout.ci(2,:),smw,-1);

tdat = abs(TD_on(11).vals(:,prng));
pout = cal_matmean(tdat,1,1);
pm = slidingmean([],pout.mean,smw,-1);
plo = slidingmean([],pout.ci(1,:),smw,-1);
phi = slidingmean([],pout.ci(2,:),smw,-1);

pt.nmean = nm;
pt.nci = [nlo;nhi];
% % pt.bmean = bm;
% % pt.bci = [blo;bhi];
pt.spmn = pm;
pt.spci = [plo;phi];

figure(111);clf;hold all
subplot(6,2,1); hold all
plot(pt.nmean,'b','linewidth',1.5)
px = [1:length(pt.nmean),length(pt.nmean):-1:1];
py = [pt.nci(1,:) pt.nci(2,end:-1:1)];
patch(px,py,'b','edgecolor','none','facealpha',.5)
plot([240 240],get(gca,'ylim'),'k:','linewidth',1.5)
set(gca,'xtick',0:120:480,'xticklabel','','yticklabel','',...
    'tickdir','out','xlim',[0 480],'ticklength',.025*[1 1])
yrn = get(gca,'ylim');

subplot(6,2,3); hold all
plot(pt.spmn,'k','linewidth',1.5)
px = [1:length(pt.spmn),length(pt.spmn):-1:1];
py = [pt.spci(1,:) pt.spci(2,end:-1:1)];
patch(px,py,'k','edgecolor','none','facealpha',.35)
set(gca,'xtick',0:120:480,'xticklabel','','yticklabel','',...
    'tickdir','out','ylim',[0 1000],'xlim',[0 480],'ticklength',.025*[1 1])
plot([240 240],get(gca,'ylim'),'k:','linewidth',1.5)

% off stuff
tdat = (TD_off(1).vals(:,prng));
nout = cal_matmean(tdat,1,1);
nm = slidingmean([],nout.mean,smw,0);
nlo = slidingmean([],nout.ci(1,:),smw,0);
nhi = slidingmean([],nout.ci(2,:),smw,0);


tdat = abs(TD_off(11).vals(:,prng));
pout = cal_matmean(tdat,1,1);
pm = slidingmean([],pout.mean,smw,-1);
plo = slidingmean([],pout.ci(1,:),smw,-1);
phi = slidingmean([],pout.ci(2,:),smw,-1);

pt.nmean = nm;
pt.nci = [nlo;nhi];
% % pt.bmean = bm;
% % pt.bci = [blo;bhi];
pt.spmn = pm;
pt.spci = [plo;phi];

figure(111);
subplot(6,2,2); hold all
plot(pt.nmean,'b','linewidth',1.5)
px = [1:length(pt.nmean),length(pt.nmean):-1:1];
py = [pt.nci(1,:) pt.nci(2,end:-1:1)];
patch(px,py,'b','edgecolor','none','facealpha',.5)
plot([240 240],yrn,'k:','linewidth',1.5)
set(gca,'xtick',0:120:480,'xticklabel','','yticklabel','',...
    'tickdir','out','xlim',[0 480],'ylim',yrn,'ticklength',.025*[1 1])


subplot(6,2,4); hold all
plot(pt.spmn,'k','linewidth',1.5)
px = [1:length(pt.spmn),length(pt.spmn):-1:1];
py = [pt.spci(1,:) pt.spci(2,end:-1:1)];
patch(px,py,'k','edgecolor','none','facealpha',.35)
set(gca,'xtick',0:120:480,'xticklabel','','yticklabel','',...
    'tickdir','out','ylim',[0 1000],'xlim',[0 480],'ticklength',.025*[1 1])
plot([240 240],get(gca,'ylim'),'k:','linewidth',1.5)
%% project triggered full circuit pattern onto pc space
load([savpath gtype '_pca_cfull.mat'],'pc')
pcol = [.9 .5 0];

