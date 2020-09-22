% clear
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
%%
load([savpath 'wt_alldata.mat'])
load([savpath 'wt_NSMon_trigdata.mat'])
cls = 2:10; %cls(cls == 4) = [];
fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
% fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
nlab = nsm_clust(fids);
vlab = vax_clust(fids);

pdat = cdata(:,cls);
% for ci = 1:10
%     pdat(:,ci) = smooth(cdata(:,ci),15);
% end

cvals = vdata;
% cvals = vlab;
cvals = cdata(:,1);

[pc,score,latent,explnd] = runPCA(pdat,0,-1,cvals);
score = zscore(pdat)*pc;
smcore = [];
for pdi = 1:size(score,2)
    smcore(:,pdi) = smooth(score(:,pdi),31);
end

figure(16);clf;hold all
% subplot(5,1,1:4);hold all
scatter3(score(:,1),smcore(:,2),smcore(:,3),15,cvals,'filled')
% scatter3(smcore(nlab==3,1),smcore(nlab==3,2),smcore(nlab==3,3),3,find(nlab==3))
view(gca,[-65.6 10.8]); grid on
if prctile(cvals,5)<-.03
    caxis([-.1 .1])
else
    caxis([0 .6])
end
% zlim([-3 5]); xlim([-3 3]); ylim([-4 4])

xlabel('PC1');ylabel('PC2');zlabel('PC3');
% subplot 515; hold all
% plot(cdata(:,1)); plot(find(nlab==3),cdata(find(nlab==3),1),'.')
colormap parula

%%
gtype = 'wt'; 
pn = [1 2];

load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])

fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
nlab = nsm_clust(fids);
vlab = vax_clust(fids);

pdat = cdata(:,cls);
cvals = cdata(:,1);
% cvals = vdata;

score = zscore(pdat)*pc;
smcore = [];
for pdi = 1:size(score,2)
    smcore(:,pdi) = smooth(score(:,pdi),31);
end

figure(13);clf;hold all
scatter(smcore(:,pn(1)),smcore(:,pn(2)),15,cvals,'filled')

% scatter3(smcore(nlab==3,1),smcore(nlab==3,2),smcore(nlab==3,3),3,find(nlab==3))
% view(gca,[-65.6 10.8]); grid on
if prctile(cvals,5)<-.03
    caxis([-.1 .1])
else
    caxis([0 .6])
end
% zlim([-3 5]); xlim([-3 3]); ylim([-4 4])

xlabel('PC1');ylabel('PC2');zlabel('PC3');
colormap parula
%%
trig_nn_traj
