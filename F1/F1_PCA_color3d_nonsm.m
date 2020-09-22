% clear
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
svon = 0;
%% PCA
cls = 2:10;
gtype = 'wt';

load([savpath gtype '_alldata.mat'])
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

%% color by foraging state
cangl = [152.920000481743 54.3599998784057];

cvals = Bst2(fids);
cmap = [.93 .69 .13;.49 .18 .56;.4 .67 .19];
cmap = getstateclr;
cmap = cmap([2 1],:);

f15=figure(15);clf;hold all
f15.OuterPosition = [354 502 267 330];

% scatter(score(:,1),-smcore(:,2),15,cvals,'filled','markerfacealpha',.2)
scatter3(score(:,1),-smcore(:,2),smcore(:,3),15,cvals,'filled','markerfacealpha',.5)
% scatter3(smcore(nlab==3,1),smcore(nlab==3,2),smcore(nlab==3,3),3,find(nlab==3))
axis equal

view(cangl);
grid('on');
caxis([1 3])
zlim([-5 5]); 
xlim([-5 6]); ylim([-5 5])

% xlabel('PC1');ylabel('PC2');zlabel('PC3');
colormap(cmap)

plotstandard
set(gca,'yticklabel','','zticklabel','')
%%
if svon
savname = [gtype '_pca_byBst_nonsm'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')
end
%% color by axial velocity
cvals = vdata/20000;
cmap = cmap_gen({[1 0 0] .5*ones(1,3) [0 1 0]},0);

f16=figure(16);clf;hold all
f16.OuterPosition = [154 502 267 330];
scatter3(score(:,1),-smcore(:,2),smcore(:,3),15,cvals,'filled','markerfacealpha',.2)
% scatter3(smcore(nlab==3,1),smcore(nlab==3,2),smcore(nlab==3,3),3,find(nlab==3))
axis equal
view(cangl);
grid('on');
caxis([-.05 .05])
zlim([-5 5]); xlim([-5 6]); ylim([-5 5])

% xlabel('PC1');ylabel('PC2');zlabel('PC3');
plotstandard
set(gca,'yticklabel','','zticklabel','')
colormap(cmap)

%%
if svon
savname = [gtype '_pca_byvax_nonsm'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')
end
%% color by NSM activity
cvals = cdata(:,1);

f14=figure(14);clf;hold all
f14.OuterPosition = [14 502 267 330];
scatter3(score(:,1),-smcore(:,2),smcore(:,3),15,cvals,'filled','markerfacealpha',.2)
% scatter3(smcore(nlab==3,1),smcore(nlab==3,2),smcore(nlab==3,3),3,find(nlab==3))
axis equal
view([151.000000481743 38.9999998784058]);
grid('on');
caxis([-.07 1])
zlim([-3 5]); xlim([-5 6]); ylim([-5 5])

xlabel('PC1');ylabel('PC2');zlabel('PC3');
colormap jet
plotstandard
set(gca,'yticklabel','')
%%
if svon
savname = [gtype '_pca_bynca'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')
end