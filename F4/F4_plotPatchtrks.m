pset(1).dir = {'C:\Users\Ni Ji\Google Drive\RD assay 22cm\20190329_Patch\20190329_Patch_WT_1_Cam5\',...
    'C:\Users\Ni Ji\Google Drive\RD assay 22cm\20190329_Patch\20190329_Patch_WT_2_Cam5\',...
    'C:\Users\Ni Ji\Google Drive\RD assay 22cm\20190812_Patch\20190812_Patch_WT_1_Cam1\'};
pset(1).gt = 'wt';
pset(1).tid = {[74 35], [32], [96]}; % 15

pset(2).dir = {'C:\Users\Ni Ji\Google Drive\RD assay 22cm\20190422_Patch\20190422_Patch_CX14597_1_0incub_Cam3\'};
pset(2).gt = 'aia';
pset(2).tid = 79;

svon = 0;

% load data and make plots
gi = 1; smw = 90;
figure(59);clf;hold all; xlim([-750 1220]); ylim([0 1220])
plot([0 0],get(gca,'ylim'),':','color',.5*[1 1 1],'linewidth',1.5)
xin = [370 500];
    tpi = 1;
for pi = 1%length(pset(gi).dir)
    curpath = pset(gi).dir{pi};
    bf = dir([curpath '*transformed_stats.mat']);
    bdf = dir([curpath '*background.mat']);
    load([curpath bf.name])
    load([curpath bdf.name])
    
    figure(59);hold all; 
%     axis equal

    for ti = pset(1).tid{pi}
        xf = xstat.xfr(ti);
        xp = xstat.trx(ti,:); xi = find(~isnan(xp)); xp = xp(xi);
        xp = xp - xp(1)+xin(tpi);
        yp = xstat.try(ti,:); yp = yp-yp(xf); yp = yp(xi);
        cp = xstat.states(ti,xi); 
        cp = xstat.spd(ti,xi); cp = (smooth(cp,smw))';
        colorline_fun(yp,xp,cp,20); caxis([0.035 .07])
        plot(yp(1),xp(1),'r.','markersize',15)
        drawnow
        tpi = tpi+1;
    end
%     [x,y] = ginput(1);
end
clrs = getstateclr;
cmap = cmap_gen_flx({clrs(2,:),clrs(1,:)},[50 100]);
colormap(cmap)
plotstandard
set(gca,'yticklabel','','xtick',-500:500:1500,'ytick',-500:500:2000)
set(gcf,'outerposition',[30 785 285 245])

if svon
savname = ['patchtrc_' pset(gi).gt]; %  '_cbar'
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')
end