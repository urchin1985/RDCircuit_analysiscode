setsavpath

set_gdirs

gtype = {'wt','wtld','aiaunc','pdfr1','tax4'};
pclr = {.2*[1 1 1],[0 0 1],[.5 .5 0],[0.5 0 .5]};

%% combine data based on genotype and make plots
mw = 20; dsth = 500;
chrm = nan(1,length(gtype)); chrel = chrm; chreh = chrm;
ddm = []; ddc = []; ddful = cell(1,2);
cxdat = cell(1,length(gtype));

fi1 = 45;fi2 = fi1+1;fic = 41; fip = 42; fit = 43;

%
for gi = 1:length(gtype)
    
    chdat = []; xgt = [];
    plclr = pclr{gi};
      
    load([bpath gtype{gi} '_fuldata.mat'])
    
    
    % speed on LD (before xing) over time
    figure(fi2+max(0,gi-2)); clf; hold all
    if gi>1
        subplot 121; hold all
        plot_bci(wpid,[wplo;wphi],wpm,pclr{1},[],[])
        subplot 122; hold all
        plot_bci(wtid,[wtlo;wthi],wtm,pclr{1},[],[])        
    end
    spd_v_time
    
    if gi==1
        wpid = spid; wplo = spclm; wphi = spchm; wpm = spdmm;
        wtid = spid2; wtlo = spclm2; wthi = spchm2; wtm = spdmm2;
    end
%         toi = 1;
%     state_trigg_gen
%     chdat = [cxmat1(stmat1==2&dsmat1<500) cxmat2(stmat2==2&dsmat2<500)];
%     spdat = [spmat1(stmat1==2&dsmat1<500) spmat2(stmat2==2&dsmat2<500)];
%     
%     % generate pre-dwell ctx history excluding first 20 min and include only
%     % dwelling that initiated within 500 pixels (~2cm) to border
%     figure(fi1); if gi==1; clf;end
%     hold all
%     plot_trigg_all(chxmat(1).ch,chxmat(2).ch,chxmat(3).ch,chxmat,plclr)
%     title(['Pre-dwelling chemotaxis index'])
%     
%     % ctx index as function of distance to border, exclude first 20 min,
%     % include only roaming states-->even only runs
%     chx_v_dist % figure fic
%     title('Chemotaxis index vs distance to border')
%     
%     %  
%     spd_v_dist % figure fip
%     title('Speed vs distance to border')
%     
%     %  
%     st_v_dist % figure fit
%     title('% Roaming vs distance to border')
%     
%     % analyze turning angle as function of current heading angle, to show
%     % degree of chemotaxis
% %     state_trigg_donly
% %     hd_vs_aspd % f39
%     
%     % compute and compare overall chemotaxis bias across genotypes
%     cmn = nanmean(chdat);
%     %     cci = bootci(200,@nanmean,chdat);
%     cse = nanstd(chdat)/sqrt(length(chdat));
%     chrm(gi) = cmn;
%     %     chrel(gi) = cmn-cci(1);
%     %     chreh(gi) = cci(2)-cmn;
%     chre(gi) = cse;
%     
%     
%     toi = 2;
%     state_trigg_gen
%     figure(40)
%     plot_trigg_all(chxmat(1).ch,chxmat(2).ch,chxmat(3).ch,chxmat,plclr)
%     title(['Pre-roaming chemotaxis index'])
    
end
%