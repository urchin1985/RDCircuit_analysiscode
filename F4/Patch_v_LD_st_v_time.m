setsavpath

set_gdirs

gztype = {'wt','wtld'};
% gztype = {'aiaunc','aiald'};
%% plot wt against ld ctrl
pclr = {.24*[1 1 1],.7*[1 1 1]}; 
mw = 20; dth = 500; fst = 20; ds = 20; dx = 50;

fid = 35; fp = 1;

figure(fid); clf; hold all
for gi = [2 1]
    plclr = pclr{gi};
    mlclr = plclr;
    
    load([bpath gztype{gi} '_fuldata.mat'])
%     toi = 1;
%     state_trigg_donly
    
    % speed/state on LD (before xing) over time
    if fp>1
        figure(fid); clf; hold all
        subplot 121; hold all
        plot_bci(wpid,[wplo;wphi],wpm,pclr{2},[])
        subplot 122; hold all
        plot_bci(wtid,[wtlo;wthi],wtm,pclr{2},[])        
    end
    spd_v_time_2
    
    if fp==1
        wpid = spid; wplo = spclm; wphi = spchm; wpm = spdmm;
        wtid = spid2; wtlo = spclm2; wthi = spchm2; wtm = spdmm2;
    end
    fp = fp+1;
end
ylim([0 .55])
%% save plots
figure(fid); hold all

savname = [gztype{gi} 'vLD_spdvdist'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')