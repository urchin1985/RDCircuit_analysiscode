setsavpath

set_gdirs

gztype = {'wt','wtld'};
% gztype = {'aiaunc','aiald'};
svon = 0;
%% plot wt against ld ctrl
pclr = {.24*[1 1 1],.7*[1 1 1]};
mw = 20; dth = 500; fst = 20; ds = 20; dx = 50;
cxdat = cell(1,gtype);

fid = 36; fp = 1;

figure(fid); clf; hold all
for gi = [2 1]
    plclr = pclr{gi};
    mlclr = plclr;
    
    load([bpath gztype{gi} '_fuldata.mat'])
    toi = 1;
    state_trigg_donly
    
    % speed/state on LD (before xing) over time
    if fp>1
        figure(fid); clf; hold all
        plot_bci(xid(wpid),[wplo;wphi],wpm,pclr{2},[],[])
    end
    ctx_v_time
    
    if fp==1
        wpid = spid; wplo = ctxlm; wphi = ctxhm; wpm = ctxmm;
    end
    fp = fp+1;
end

%% save plots
if svon
    figure(fid); hold all
    
    savname = [gztype{gi} 'vLD_ctxvtime'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
end
saveas(gcf,[savpath2 savname '.eps'],'epsc')