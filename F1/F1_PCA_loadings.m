% clear
setsavpath
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

%% PCA for all neurons
cls = 1:10;
gtype = 'wtf';

load([savpath gtype '_alldata_e2.mat'])
% load([savpath gtype '_NSMon_trigdata.mat'])
% fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
nlab = nsm_clust(fids);
vlab = vax_clust(fids);

pdat = cdata(:,cls); 

cvals = vdata/20000;
% cvals = vlab;
cvals = cdata(:,1);


[pc,score,latent,explnd] = runPCA(pdat,0,-1,cvals);
score = zscore(pdat)*pc;
smcore = [];
for pdi = 1:size(score,2)
   smcore(:,pdi) = smooth(score(:,pdi),31); 
end

% color by NSM activity
cvals = cdata(:,1);

f14=figure(14);clf;hold all
f14.OuterPosition = [14 502 267 330];
scatter3(score(:,1),smcore(:,2),smcore(:,3),15,cvals,'filled','markerfacealpha',.2)
% scatter3(smcore(nlab==3,1),smcore(nlab==3,2),smcore(nlab==3,3),3,find(nlab==3))
axis equal
% view([151.000000481743 38.9999998784058]);
grid('on');
caxis([-.07 1])
zlim([-3 5]); xlim([-5 6]); ylim([-5 5])

xlabel('PC1');ylabel('PC2');zlabel('PC3');
colormap jet

% plot loadings
pn = size(score,2);

figure(40);clf; hold all
for pi = 1:pn
    subplot(pn,1,pi); hold all
    bar(pc(:,pi),'facecolor',.4*[1 1 1],'barwidth',.5)
    plotstandard
    ylim([-.5 .5])
    set(gca,'xtick',1:pn,'ytick',-.5:.5:.5)
end
%%
savname = [gtype '_pcaloadings_all'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')

%% PCA exclude NSM
cls = 2:10;
gtype = 'wtf';

load([savpath gtype '_alldata_e2.mat'])
% load([savpath gtype '_NSMon_trigdata.mat'])
% fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
nlab = nsm_clust(fids);
vlab = vax_clust(fids);

pdat = cdata(:,cls); 

cvals = vdata/20000;
% cvals = vlab;
cvals = cdata(:,1);


[pc,score,latent,explnd] = runPCA(pdat,0,-1,cvals);
score = zscore(pdat)*pc;
smcore = [];
for pdi = 1:size(score,2)
   smcore(:,pdi) = smooth(score(:,pdi),31); 
end

% color by NSM activity
cvals = cdata(:,1);

f14=figure(14);clf;hold all
f14.OuterPosition = [14 502 267 330];
scatter3(score(:,1),smcore(:,2),smcore(:,3),15,cvals,'filled','markerfacealpha',.2)
% scatter3(smcore(nlab==3,1),smcore(nlab==3,2),smcore(nlab==3,3),3,find(nlab==3))
axis equal
% view([151.000000481743 38.9999998784058]);
grid('on');
caxis([-.07 1])
zlim([-3 5]); xlim([-5 6]); ylim([-5 5])

xlabel('PC1');ylabel('PC2');zlabel('PC3');
colormap jet

% plot loadings
pn = size(score,2);

figure(40);clf; hold all
for pi = 1:pn
    subplot(pn,1,pi); hold all
    bar(pc(:,pi),'facecolor',.4*[1 1 1],'barwidth',.5)
    plotstandard
    ylim([-.5 .5])
    set(gca,'xtick',1:pn,'ytick',-.5:.5:.5)
end

%%
savname = [gtype '_pcaloadings_noNSM'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')