setsavpath

set_gdirs

gtype = {'wt','wtld','aiaunc','pdfr1','tax4','tph1'};
% gztype = {'aiaunc','aiald'};
svon = 0;
%% roaming focused analyses
pclr = {.14*[1 1 1],.4*[1 1 1],.5*[0 1 0],[0 0 1],[.64 .08 .18],[.85 .5 0]};
mclr = pclr;
mw = 20; dth = 650; fst = 20; ds = 20; dx = 50;
gl = length(gtype);
rdurm = nan(1,gl); rdurs = cell(1,gl); rpm = rdurm; rpci = [rpm;rpm];
drpp = nan(1,gl); spdef = nan(gl,2);

fid = 38; fp = 1; sptb = [];

for gi = 1:length(gtype)
    plclr = pclr{gi};
    mlclr = plclr;
    
    load([bpath gtype{gi} '_fuldata.mat'])
   
    rec_d2b
    
    
end

% fdrpp = mafdr(drpp,'BHFDR',true)
%% save plots
if svon
    for gi = 1:length(gtype)
        if gi>1
        figure(fid+gi-1); hold all
        set(gca,'ytick',0:.15:.3)
        savname = [gtype{gi} 'vwt_sttrigctx_dw'];
        saveas(gcf,[savpath2 savname '.tif'])
        saveas(gcf,[savpath2 savname '.fig'])
        saveas(gcf,[savpath2 savname '.eps'],'epsc')
        end
        
        figure(fid+10+gi-1); hold all
        set(gca,'ytick',0:.15:.3)
        savname = [gtype{gi} 'vwt_prdwctx_cf'];
        saveas(gcf,[savpath2 savname '.tif'])
        saveas(gcf,[savpath2 savname '.fig'])
        saveas(gcf,[savpath2 savname '.eps'],'epsc')
    end
    
    save([savpath savname '.mat'],'fdrpp','gtype')
end