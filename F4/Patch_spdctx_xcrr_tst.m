setsavpath

set_gdirs

gtype = {'wt','aiaunc','pdfr1','tax4','tph1'};
svon = 0;
%% combine data based on genotype and make plots
% pclr = {.4*[1 1 1],[0 0 1],[.5 .5 0],[0.5 0 .5]};
pclr = {.14*[1 1 1],.5*[0 1 0],[0 0 1],[.64 .08 .18],[.85 .5 0]};
mw = 20; dth = 500; fst = 20; ds = 25; dx = 50; xb = 180;
chrm = nan(1,length(gtype)); chrel = chrm; chreh = chrm;
ddm = []; ddc = []; ddful = cell(1,2);

fi1 = 25;fi2 = fi1+1;fic = 41; fip = 42; fit = 43;

%
for gi = 1:length(gtype)
    fid = fi2+max(0,gi-2);
    plclr = pclr{gi};
    
    if gi>1
        figure(fid); clf; hold all
        plot_bci(-xb:xb,wxf.ci,wxf.mean,pclr{1},[],[])
        plot([-xb xb],[0 0],'k','linewidth',1)
        plot([0 0],[-1 1],'k:','linewidth',1.5)
    end
    
    load([bpath gtype{gi} '_fuldata.mat'])
    spd_ctx_xcrr_2
            
    if gi==1
        wxf = xmf;
        close
    end
end

%% save plots
if svon
    for gi = 2:length(gtype)
        
        figure(fi2+max(0,gi-2)); hold all
        savname = [gtype{gi} '_spdctx_cxcrr'];
        saveas(gcf,[savpath2 savname '.tif'])
        saveas(gcf,[savpath2 savname '.fig'])
        saveas(gcf,[savpath2 savname '.eps'],'epsc')
    end
end