%% state-trans targeted PCA
load([savpath gtype '_statetrans_PCA_15s.mat'],'T_on','P_on','tpre','tpost')

for ci = 1:length(T_on)
    pdat = T_on(ci).vals(:);
    
end

[pc,score,latent,explnd] = runPCA(pdat,0,0,cvals);
score = zscore(pdat)*pc;
smcore = [];
for pdi = 1:size(score,2)
    smcore(:,pdi) = smooth(score(:,pdi),31);
end
%
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