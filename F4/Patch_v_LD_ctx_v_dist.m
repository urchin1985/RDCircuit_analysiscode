setsavpath

set_gdirs

% gtype = {'wt','aiaunc','pdfr1','tax4'};
gztype = {'wtld','wt'};
svon = 0;
%% combine data based on genotype and make plots
% pclr = {.4*[1 1 1],[0 0 1],[.5 .5 0],[0.5 0 .5]};
% pclr = {.5*[1 1 1],.5*[0 1 0],.5*[1 0 1],[.64 .08 .18]};
pclr = {.6*[1 1 1],[0 0 1]}; 
mw = 20; dth = 500; fst = 20; ds = 25; dx = 50;
chrm = nan(1,length(gtype)); chrel = chrm; chreh = chrm;
ddm = []; ddc = []; ddful = cell(1,2);

fid = 36; fp = 1;

%
for gi = 1:length(gztype)
  
    plclr = pclr{gi};
      
    load([bpath gztype{gi} '_fuldata.mat'])
    toi = 1;
    state_trigg_donly
    
    % speed on LD (before xing) over time
    if gi>1
        figure(fid); clf; hold all
        plot_bci_mc(wpx,wpci,wpm,wpcl,[],pclr{1})        
    end
    ctx_v_dist_2
    
    if gi==1
        wpx = dout; wpm = cout; wpci = ciout; wpcl = clout;
    end
end

  %% save plots
  if svon
    figure(fid); hold all

    savname = 'wtvLD_ctxvdist';
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
  end