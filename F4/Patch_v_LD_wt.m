setsavpath

set_gdirs

gtype = {'wt','wtld'};

%% plot wt against ld ctrl
pclr = {[0.2 0.5 0.3],.4*[1 1 1]};
mw = 20; dth = 500; fst = 20; ds = 20; dx = 50;

fid = 35;

figure(fid); clf; hold all
for gi = [2 1]
    plclr = pclr{gi};
    
    load([bpath gtype{gi} '_fuldata.mat'])
    toi = 1;
    state_trigg_donly
    
    % speed on LD (before xing) over time
    spd_v_dist_2

end
%% save plots
for gi = 2:length(gtype)
    figure(fi2+max(0,gi-2)); hold all
    
    savname = [gtype{gi} 'vLD_spdvdist'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
end