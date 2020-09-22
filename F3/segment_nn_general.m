%% run duration and speed analysis
Xd = []; coi = 8;
for fi = 1:max(Fdx) %[1 3 4 7:max(Fdx)] % 1:max(Fdx) %
    di = find(Fdx == fi);
    vdata = Cdat(di,coi);
%     vdata = medfilt1(vdata/prctile(vdata,99),5);
    vbin = medfilt1(double(vdata>=.3),7);
    % %%
    % di = find(Fdx == 8);
    % yin = Vdat(di);
    xin = 1:length(vdata);
    yin = vdata/prctile(vdata,99);
    vmed = slidingmedian(xin,yin,55,0);
    vmin = slidingmin(1:length(vmed),vmed,1700,0);
    vmed = vmed - vmin;
    vvar = slidingvar(xin,vmed,85,0);
    
    pid = vmed>=-.1;
    Xd = [Xd; [(abs(vmed(:))) log(abs(vvar(:))) fi*ones(length(vmed),1)]];
    
% %     figure(16);clf;hold all
% %     plot(vdata)
% %     plot(vmed)
% %     plot(vbin)
    
% %     figure(17);clf;hold all
% %     % plot(abs(vmed),abs(vvar),'o','markersize')
% %     histogram2((abs(vmed(:))),log(abs(vvar(:))),0:.03:1,-9:.3:.3,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
% %     % scatterhist(abs(vmed(:)),log(abs(vvar(:))))
% %     colormap jet
%     max(vmed)
%     max(log(abs(vvar)))
%     pause(.05)
end

%% fit GMM and perform clustering
cln = 3;
options = statset('MaxIter',1000);
gmfit = fitgmdist(Xd(:,1:2),cln,'Options',options);
%
figure(18);clf;hold all
% scatter(Xd(:,1),Xd(:,2))
histogram2(Xd(:,1),Xd(:,2),-.1:.015:1,-13:.3:.3,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
colormap bone
set(gca,'xlim',[-.1 1],'ylim',[-13 -3.3])
% h = ezcontour(@(x,y)pdf(gmfit,[x y]),get(gca,{'XLim','YLim'}));
% set(h,'linewidth',1.5,'levelstep',.05)
set(gca,'xlim',[-.1 1],'ylim',[-13 -3.3])
%
d=500;
x1 = linspace(min(Xd(:,1)) - 2,max(Xd(:,1)) + 2,d);
x2 = linspace(min(Xd(:,2)) - 2,max(Xd(:,2)) + 2,d);
[x1grid,x2grid] = meshgrid(x1,x2);
X0 = [x1grid(:) x2grid(:)];
threshold = sqrt(chi2inv(0.5,2));
clx = cluster(gmfit,Xd(:,1:2));
mahalDist = mahal(gmfit,X0);

for m = 1:cln
    idx = mahalDist(:,m)<=threshold;
    h2 = plot(X0(idx,1),X0(idx,2),'.','MarkerSize',3);
    uistack(h2,'bottom');
end
plot(gmfit.mu(:,1),gmfit.mu(:,2),'kx','LineWidth',2,'MarkerSize',10)

gmfit.AIC
%% save GM model
% save([savpath gtype '_NSM_gmfit_e.mat'],'Xd','Fdx','gmfit','AIC','BIC') % ,'-append'
save([savpath gtype '_' cnmvec{coi} '_gmfit.mat'],'Xd','Fdx','gmfit')
ca_gmfit = gmfit.mu;

% % savname = ['wt_nsmclust_mod_e2'];
% % saveas(gcf,[savpath2 savname '.tif'])
% % saveas(gcf,[savpath2 savname '.fig'])
% % saveas(gcf,[savpath2 savname '.eps'],'epsc')
%% assign class label to data points
for fi = unique(Fdx')
di = find(Fdx == fi);
vdata = Vdat(di);%Cdat(di,1);
cdata = Cdat(di,1);
di = find(Xd(:,3) == fi);
xdata = Xd(di,1:2);
clid = clx(di);

% % figure(18);clf;hold all
% % % scatter(Xd(:,1),Xd(:,2))
% % histogram2(Xd(:,1),Xd(:,2),0:.015:1,-13:.3:.3,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
% % colormap bone
% % set(gca,'xlim',[0 1],'ylim',[-13 .3])

figure(16);clf;hold all
% plot(vdata)
plot(xdata(:,1))
plot(vdata/prctile(vdata,99))
plot(cdata,'k')
% xmin = slidingmin(1:length(xdata),xdata(:,1),1700,0);
% plot(xmin,'o-')
%    plot((xdata(:,1))'-xmin)
plot([1 length(vdata)],[0 0],'k:')
for m = 1:cln
   idx = find(clid==m);
   if ~isempty(idx)
   figure(16)
   h = plot(idx,xdata(idx,1),'.','markersize',6)
%    plot(idx,vdata(idx,1),'.','markersize',6)
% %    figure(18);hold all
% %    plot(xdata(idx,1),xdata(idx,2),'.','color',h.Color,'markersize',7)
   end
end
figure(16)
plot(-xdata(:,2)/max(abs(xdata(:,2))))
plot(clid)
xlim([0 length(vdata)+5])
ylabel('Normalized axial velocity')
[x,y] = ginput(1);
end

%% model selection
BIC = zeros(1,4);AIC = zeros(1,4);
GMModels = cell(1,4);
options = statset('MaxIter',500);
for k = 1:10
    GMModels{k} = fitgmdist(Xd(:,1:2),k,'Options',options,'CovarianceType','diagonal');
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

% figure(18);clf;hold all
% scatter(Xd(:,1),Xd(:,2))
% h = ezcontour(@(x,y)pdf(GMModels{nc},[x y]),get(gca,{'XLim','YLim'}));
% set(h,'linewidth',1.5,'levelstep',.1)
%%
savname = ['wt_nsmclust_modsel'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')
