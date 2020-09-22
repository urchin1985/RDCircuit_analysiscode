gi = 1; smw = 60;

if ~exist('plw','var')
plw = 20;
end

xp = xstat.trx(ti,:); yp = xstat.try(ti,:); 
xi = find(~isnan(xp)&~isnan(yp)); 
xp = xp(xi); yp = yp(xi);
cp = xstat.states(ti,xi);
% cp = xstat.spd(ti,xi); cp = (smooth(cp,smw))';
colorline_fun(xp,yp,cp,plw); %caxis([0.035 .07]); 
hold all
plot(xp(1),yp(1),'r.','markersize',15)
plot(xp(end),yp(end),'k.','markersize',15)

xlim([nanmin(xp)-100 nanmax(xp)+100]); 
ylim([nanmin(yp)-100 nanmax(yp)+100])

title(num2str(ti))
axis equal
% clrs = getstateclr;
% cmap = cmap_gen_flx({clrs(3,:),clrs(1,:)},[50 100]);
% colormap(cmap)