% clear
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath

gtype = 'wte';
load([savpath gtype '_alldata.mat'],'Cdat','Tdat','Vdat','Fdx')
%% run duration and speed analysis
Xd = [];
for fi = 1:max(Fdx)
    di = find(Fdx == fi);
    vdata = Vdat(di);
    vdata = medfilt1(vdata/prctile(vdata,99),5);
    vbin = medfilt1(double(vdata>=-.05),7);
    % %%
    % di = find(Fdx == 8);
    % yin = Vdat(di);
    xin = 1:length(vdata);
    yin = vdata/prctile(vdata,99);
    vmed = slidingmedian(xin,yin,55,0);
    vvar = slidingvar(xin,yin,55,0);
    
    pid = vmed>=-.1;
    Xd = [Xd; [((vmed(:))) log(abs(vvar(:)))]];
    
% %     figure(16);clf;hold all
% %     plot(vdata)
% %     plot(vmed)
% %     plot(vbin)
% %     
% %     figure(17);clf;hold all
% %     % plot(abs(vmed),abs(vvar),'o','markersize')
% %     histogram2((abs(vmed(:))),log(abs(vvar(:))),0:.03:1,-9:.3:.3,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
% %     % scatterhist(abs(vmed(:)),log(abs(vvar(:))))
% %     colormap jet
% %     max(vmed)
% %     max(log(abs(vvar)))
% %     pause(.05)
end

%% fit GMM and perform clustering
cln = 4;
gmfit = fitgmdist(Xd,cln);
%%
figure(18);clf;hold all
% scatter(Xd(:,1),Xd(:,2))
histogram2(Xd(:,1),Xd(:,2),-1:.03:1,-9:.3:.3,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
colormap bone
set(gca,'xlim',[-1 1],'ylim',[-9 .3])
% h = ezcontour(@(x,y)pdf(gmfit,[x y]),get(gca,{'XLim','YLim'}));
% set(h,'linewidth',1.5,'levelstep',.05)
% set(gca,'xlim',[-1 1],'ylim',[-9 .3]);
%
d=500;
x1 = linspace(min(Xd(:,1)) - 2,max(Xd(:,1)) + 2,d);
x2 = linspace(min(Xd(:,2)) - 2,max(Xd(:,2)) + 2,d);
[x1grid,x2grid] = meshgrid(x1,x2);
X0 = [x1grid(:) x2grid(:)];
threshold = sqrt(chi2inv(0.5,2));
clx = cluster(gmfit,Xd);
mahalDist = mahal(gmfit,X0);
cst = {[.4 .67 .19],[.49 .18 .56],[.93 .69 .13],[.85 .33 .1]};

for m = 1:cln
    idx = mahalDist(:,m)<=threshold;
    h2 = plot(X0(idx,1),X0(idx,2),'.','MarkerSize',3);
    uistack(h2,'bottom');
end
% plot(gmfit.mu(:,1),gmfit.mu(:,2),'kx','LineWidth',2,'MarkerSize',10)
plotstandard
set(gca,'xtick',-1:.5:1,'ytick',-9:3:0,'yticklabel','')
% xlabel('median axial velocity');ylabel('variance')
axis square

saveas(gcf,[savpath2 gtype '_vax_gmm.tif'])
saveas(gcf,[savpath2 gtype '_vax_gmm.fig'])
saveas(gcf,[savpath2 gtype '_vax_gmm.eps'],'epsc')

%% visualize against vax and NSM ca traces
for fi = unique(Fdx')
    di = find(Fdx == fi);
    ndata = Cdat(di,1);
    vdata = Vdat(di);
    vdata = medfilt1(vdata/prctile(vdata,99),5);
    clid = clx(di);
    
    figure(16);clf;hold all
    subplot 211; hold all
    plot(vdata); plot(clid); plot([1 length(vdata)],[0 0],'k:')
    for m = 1:cln
        idx = find(clid==m);
        plot(idx,vdata(idx),'.','markersize',6)
    end
    xlim([0 length(vdata)+5])
    ylabel('Normalized axial velocity')
    
        subplot 212; hold all
    plot(ndata); plot(clid); plot([1 length(vdata)],[0 0],'k:')
    for m = 1:cln
        idx = find(clid==m);
        plot(idx,ndata(idx),'.','markersize',6)
    end
    xlim([0 length(ndata)+5])
    ylabel('NSM activity')
    
    [x,y] = ginput(1);
end
%% save GM model
save([savpath gtype '_vax_gmfit.mat'],'Xd','Fdx','gmfit') %,'-append','AIC','BIC',
%% Overlay with NSM activity
fi = 5;
di = find(Fdx == fi);
vdata = Vdat(di);
vdata = medfilt1(vdata/prctile(vdata,99),5);
clid = clx(di);
ndata = Cdat(di,1);
ndata = medfilt1(ndata/3,5);
figure(16);clf;hold all
plot(vdata,'k')
plot([1 length(vdata)],[0 0],'k:')
for m = 1:cln
   idx = find(clid==m);
   plot(idx,ndata(idx),'.','markersize',7)
end
plot(clid)
xlim([0 length(vdata)+5])
ylabel('Normalized NSM activity')

%% calculate NSM histogram for each cluster group
ndata = Cdat(:,1);
ndata = medfilt1(ndata,5);
figure(19);clf;hold all
for m = 1:cln
    idx = find(clx==m);
    nvals = ndata(idx);
    [n,nc] = hist(nvals,30);
    np = n/sum(n);
     plot(nc,np,'o-','linewidth',1.5)
end
legend('vmed = -0.3 vvar = 1e-1.9',...
    'vmed = 0.4 vvar = 1e-3.7',...
    'vmed = 0.06 vvar = 1e-5.3',...
    'vmed = 0.2 vvar = 1e-1.4')
xlabel('NSM activity'); ylabel('Probability')

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