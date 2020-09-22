
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath

gtype = 'wtf';
load([savpath gtype '_alldata.mat'],'Cdat','Tdat','Vdat','Fdx','Bst','bstates')

ckflg = 0;
%% calculate NSM histogram for each behavior state
ndata = Cdat(:,1);
ndata = medfilt1(ndata,5);
nbn = -.25:.125:2;

figure(19);clf;hold all
for m = 1:max(Bst)
    idx = find(Bst==m);
    nvals = ndata(idx);
    [n,nc] = hist(nvals,nbn);
    np = n/sum(n);
     plot(nc,np,'o-','linewidth',1.5)
end
legend
xlabel('NSM activity'); ylabel('Probability')

plotstandard
set(gca,'xtick',-1:.5:2,'ytick',0:.1:1,'yticklabel','')
% xlabel('median axial velocity');ylabel('variance')
axis square
%%
savname = '_nsmca_bstate_hist';
saveas(gcf,[savpath2 gtype savname '.tif'])
saveas(gcf,[savpath2 gtype savname '.fig'])
saveas(gcf,[savpath2 gtype savname '.eps'],'epsc')