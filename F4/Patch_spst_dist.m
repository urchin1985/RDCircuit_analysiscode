setsavpath

set_gdirs

gtype = {'wt','aiaunc','pdfr1','tax4'};

%% combine data based on genotype and make plots
% pclr = {.4*[1 1 1],[0 0 1],[.5 .5 0],[0.5 0 .5]};
pclr = {.5*[1 1 1],.5*[0 1 0],.5*[1 0 1],[.64 .08 .18]};
mw = 20; dth = 500; fst = 20; ds = 25; dx = 50;
chrm = nan(1,length(gtype)); chrel = chrm; chreh = chrm;
ddm = []; ddc = []; ddful = cell(1,2);

fi1 = 45;fi2 = fi1+1;fic = 41; fip = 42; fit = 43;

%
for gi = 2:length(gtype)
    fid = fi2+max(0,gi-2);
       
    plclr = pclr{gi};
      
    load([bpath gtype{gi} '_fuldata.mat'])
    toi = 1;
    state_trigg_donly
    
    % speed on LD (before xing) over time
    figure(fid); clf; hold all
    if gi>1
        subplot 121; hold all
        plot_bci_mc(wpx,wpci,wpm,wpcl,[],pclr{1})
        subplot 122; hold all
        plot_bci_mc(wtx,wtci,wtm,wtcl,[],pclr{1})        
    end
    spd_v_dist_2
    
    if gi==1
        wpx = dout; wpm = cout; wpci = ciout; wpcl = clout;
        wtx = dout2; wtm = cout2; wtci = ciout2; wtcl = clout2;
    end
end

  %% save plots
for gi = 2:length(gtype)
    
    figure(fi2+max(0,gi-2)); hold all

    savname = [gtype{gi} '_spdvdist'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
end