figure(85);clf; hold all
subplot 131; hold all
% scatter PC1-3 with axial vel
pi=1;
% scatter(score(:,pi),vdata)
h = histogram2(score(:,pi),(vdata),-4:.2:4,-.15:.01:.15,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on');
h.EdgeColor = 'none';
hold all;
plot([-4 4],[0 0],'k'); plot([0 0],[-.15 .15],'k')
xlim([-4 4]); ylim([-.12 .15])
plotstandard
set(gca,'yticklabel','')
% xeds = -4:.2:4; yeds = -.01:.01:.15;
% [N,Xedges,Yedges] = histcounts2(score(:,pi),abs(vdata),xeds,yeds);
% imagesc(N)


subplot 132; hold all
% scatter PC1-3 with axial vel
pi=2;
% scatter(score(:,pi),vdata)
h = histogram2(score(:,pi),abs(vdata),-4:.2:4,-.01:.01:.15,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on');
h.EdgeColor = 'none';
hold all;
plot([-4 4],[0 0],'k'); plot([0 0],[-.15 .15],'k')
xlim([-3 3]); ylim([-.01 .15])
plotstandard
set(gca,'yticklabel','')


subplot 133; hold all
% scatter PC1-3 with axial veleeeee
pi=3;
% scatter(score(:,pi),vdata)
h = histogram2(score(:,pi),abs(vdata),-4:.2:4,-.05:.01:.15,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on');
h.EdgeColor = 'none';
hold all;
plot([-4 4],[0 0],'k'); plot([0 0],[-.05 .15],'k')
xlim([-3 3]); ylim([-.01 .15])
plotstandard
set(gca,'yticklabel','')

colormap parula
% ylim([-.25 .25])