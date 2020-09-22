setsavpath

set_gdirs

gtype = {'wt','aiaunc','pdfr1','tax4'};
% pclr = {.2*[1 1 1],[0 0 1],[.5 .5 0],[0.5 0 .5]};
%% combine data based on genotype and make plots
pclr = {.5*[1 1 1],.5*[0 1 0],.5*[1 0 1],[.64 .08 .18]};
mclr = {.6*[1 1 1],.5*[0 1 0],.5*[1 0 1],[.64 .08 .18]};

mw = 20; dsth = 500;
chrm = nan(1,length(gtype)); chrel = chrm; chreh = chrm;
ddm = []; ddc = []; ddful = cell(1,2);

fi1 = 45;fi2 = fi1+1;fic = 41; fip = 42; fit = 43;

%
for gi = 1:length(gtype)
        
    chdat = []; xgt = [];
    plclr = pclr{gi};
    mlclr = mclr{gi};
      
    load([bpath gtype{gi} '_fuldata.mat'])
    
    % speed on LD (before xing) over time
    figure(fi2+max(0,gi-2)); clf; hold all
    if gi>1
        subplot 121; hold all
        plot_bci(wpid,[wplo;wphi],wpm,pclr{1},mclr{1})
        subplot 122; hold all
        plot_bci(wtid,[wtlo;wthi],wtm,pclr{1},mclr{1})        
    end
    spd_v_time_2
    
    if gi==1
        wpid = spid; wplo = spclm; wphi = spchm; wpm = spdmm;
        wtid = spid2; wtlo = spclm2; wthi = spchm2; wtm = spdmm2;
    end

    
end
%% save plots
for gi = 2:length(gtype)
    
    figure(fi2+max(0,gi-2)); hold all

    savname = [gtype{gi} '_spstvtime'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
end