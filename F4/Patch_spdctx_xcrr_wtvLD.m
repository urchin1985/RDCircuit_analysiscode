setsavpath

set_gdirs

gztype = {'wtld','wt'};
%% combine data based on genotype and make plots
pclr = {.6*[1 1 1],.14*[1 1 1]};
mw = 20; dth = 500; fst = 20; ds = 25; dx = 50;
chrm = nan(1,length(gtype)); chrel = chrm; chreh = chrm;
ddm = []; ddc = []; ddful = cell(1,2);

fid = 36; fp = 1; xb = 180;
figure(fid); clf; hold all
        plot([-xb xb],[0 0],'k','linewidth',1)
        plot([0 0],[-1 1],'k:','linewidth',1.5)

for gi = 1:length(gztype)
    
    plclr = pclr{gi};
    
    load([bpath gztype{gi} '_fuldata.mat'])
    
    spd_ctx_xcrr
    
end
%% save plots
figure(fid); hold all

savname = 'wtvLD_spdctx_cxcrr';
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')