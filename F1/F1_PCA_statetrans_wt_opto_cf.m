% clear
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
%%
vwa = [-107.6 17.9]; % [-65.6 10.8]
gtype = 'wt';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
% fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
nlab = nsm_clust(fids);
vlab = vax_clust(fids);

cls = 1:10; %cls(cls == 4) = [];
pdat = cdata(:,cls);
dt = 60;

cvals = vdata;
% cvals = vlab;
cvals = cdata(:,1);

[pc,score,latent,explnd] = runPCA(pdat,0,0,cvals);
score = zscore(pdat)*pc;
smcore = [];
for pdi = 1:size(score,2)
    smcore(:,pdi) = smooth(score(:,pdi),31);
end
%%
figure(16);clf;hold all
% subplot(5,1,1:4);hold all
scatter3(smcore(:,1),smcore(:,2),smcore(:,6),15,cvals,'filled')
% scatter3(smcore(nlab==3,1),smcore(nlab==3,2),smcore(nlab==3,3),3,find(nlab==3))
view(gca,vwa); grid on
if prctile(cvals,5)<-.03
    caxis([-.1 .1])
else
    caxis([0 .6])
end
% zlim([-3 5]); xlim([-3 3]); ylim([-4 4])

xlabel('PC1');ylabel('PC2');zlabel('PC3');
colormap parula
%%
savname = [savpath2 gtype '_pca_' num2str(cls(1)) num2str(cls(end))];
saveas(gcf,[savname '.tif'])
saveas(gcf,[savname '.fig'])
saveas(gcf,[savname '.eps'],'epsc')


%% project NSM activation dynamics on PC space
foi = 15; coi = 1;

trig_PCA_traj
trig_PCA_traj_direct

trig_PCA_traj_wb

wpl = pl; wprm = prm; wpom = pom;
%% tph-1Chrimson
gtype = 'tph1Chm';

load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])

fids = find(Fdx>0);
cdata = Cdat(fids,1:10);
fidata = Fdx(fids);
vdata = Vdat(fids);
% nlab = nsm_clust(fids);
% vlab = vax_clust(fids);
% cvals = vdata/20000;
% cvals = vlab;
cvals = cdata(:,1);

pdat = cdata(:,cls);

score = zscore(pdat)*pc;
smcore = [];
for pdi = 1:size(score,2)
    smcore(:,pdi) = smooth(score(:,pdi),31);
end

figure(13);clf;hold all
scatter3(smcore(:,1),smcore(:,2),smcore(:,3),15,cvals,'filled')
% scatter3(smcore(nlab==3,1),smcore(nlab==3,2),smcore(nlab==3,3),3,find(nlab==3))
% view(gca,[-65.6 10.8]); grid on
view(gca,vwa); grid on
caxis([0 .6])
zlim([-4 6]); xlim([-4 6]); ylim([-4 4])

xlabel('PC1');ylabel('PC2');zlabel('PC3');
colormap parula

savname = [savpath2 gtype '_pca_' num2str(cls(1)) num2str(cls(end))];
saveas(gcf,[savname '.tif'])
saveas(gcf,[savname '.fig'])
saveas(gcf,[savname '.eps'],'epsc')

% project opto response dynamics on PC space
foi = 18;
trig_opto_traj
trig_opto_traj_wb
%% gcy-28Chrimson
gtype = 'gcy28Chmful';

load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])

fids = find(Fdx>0);
cdata = Cdat(fids,1:10);
fidata = Fdx(fids);
vdata = Vdat(fids);
nlab = nsm_clust(fids);
vlab = vax_clust(fids);
% cvals = vdata/20000;
% cvals = vlab;
cvals = cdata(:,1);

pdat = cdata(:,cls);

score = zscore(pdat)*pc;
smcore = [];
for pdi = 1:size(score,2)
    smcore(:,pdi) = smooth(score(:,pdi),31);
end

figure(14);clf;hold all
scatter3(smcore(:,1),smcore(:,2),smcore(:,3),15,cvals,'filled')
% scatter3(smcore(nlab==3,1),smcore(nlab==3,2),smcore(nlab==3,3),3,find(nlab==3))
view(gca,vwa); grid on
caxis([0 .6])
zlim([-4 6]); xlim([-4 6]); ylim([-4 4])

xlabel('PC1');ylabel('PC2');zlabel('PC3');
colormap parula

if svon
savname = [savpath2 gtype '_pca_' num2str(cls(1)) num2str(cls(end))];
saveas(gcf,[savname '.tif'])
saveas(gcf,[savname '.fig'])
saveas(gcf,[savname '.eps'],'epsc')
end

% project opto response dynamics on PC space
foi = 19;
trig_opto_traj