setsavpath
svon = 0;

rdfile = [savpath '20190304_LD_WT_1_Cam3.transformed_stats.mat'];
load(rdfile,'xstat')

pln = 2; bd.x = nan; bd.y = nan;
figure(105); clf; hold all;
subplot(3,1,[1 2])
ti = 34; plw = 50; 
ptrkclr

clrs = getstateclr;
cmap = cmap_gen_flx({clrs(2,:),clrs(1,:)},[50 100]);
colormap(cmap)
plotstandard
set(gca,'xtick',0:500:5000,'ytick',800:500:5000,'yticklabel','')
title('')
% axis equal
%%
subplot(3,1,3);cla; hold all
smw = 90; 
sp = xstat.spd(ti,:); pid = find(~isnan(sp));
xt = pid/180; xt = xt-xt(1);
sp = (smooth(sp(~isnan(sp)),smw))';
colorline(xt,nanmax(sp)*1.1,xstat.states(ti,pid),.015)
plot(xt,sp,'k','linewidth',1);
xlim([xt([1 end])])
plotstandard
set(gca,'ytick',0:0.1:0.2,'yticklabel','','xtick',0:20:180)
%%
if svon
savname = 'wtRDtraj';
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')
end