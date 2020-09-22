%% calculate NSM histogram for each cluster group
ndata = Cdat(:,1);
ndata = medfilt1(ndata,5);
nbn = -.25:.125:2.5;

figure(19);clf;hold all
for m = 1:cln
    idx = find(clx==m);
    nvals = ndata(idx);
    [n,nc] = hist(nvals,nbn);
    np = n/sum(n);
     plot(nc,np,'o-','linewidth',1.5)
end
legend
xlabel('NSM activity'); ylabel('Probability')

plotstandard
set(gca,'xtick',-1:.5:1,'ytick',0:.2:1,'yticklabel','')
% xlabel('median axial velocity');ylabel('variance')
axis square

savname = '_nsmca_bclst_histe2';
saveas(gcf,[savpath2 gtype savname '.tif'])
saveas(gcf,[savpath2 gtype savname '.fig'])
saveas(gcf,[savpath2 gtype savname '.eps'],'epsc')
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

savname = '_nsmca_bstate_histe2';
saveas(gcf,[savpath2 gtype savname '.tif'])
saveas(gcf,[savpath2 gtype savname '.fig'])
saveas(gcf,[savpath2 gtype savname '.eps'],'epsc')
%% model selection
BIC = zeros(1,4);AIC = zeros(1,4);
GMModels = cell(1,4);
options = statset('MaxIter',500);
for k = 1:10
    GMModels{k} = fitgmdist(Xd,k,'Options',options,'CovarianceType','diagonal');
    BIC(k)= GMModels{k}.BIC;
    AIC(k)= GMModels{k}.AIC;
end

[minBIC,nc] = min(BIC);
[minAIC,nc] = min(AIC);

figure(11);clf; hold on
subplot 121;plot(BIC,'O-')
title('BIC');xlabel('# of Gaussians')
subplot 122;plot(AIC,'O-')
title('AIC');xlabel('# of Gaussians')

figure(18);clf;hold all
scatter(Xd(:,1),Xd(:,2))
h = ezcontour(@(x,y)pdf(GMModels{nc},[x y]),get(gca,{'XLim','YLim'}));
set(h,'linewidth',1.5,'levelstep',.1)