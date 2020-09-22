setsavpath
DirLog

cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};
corder = [1 4 2 3 5 6 7 8 9 10];

svon = 0;
%% first survey all triggered instances
gztype = {'wt' 'wtd' 'wtf'};
gzi = {[9],[3],[55]};
tx = (-600:600)*.5; smw = 30; tp = 1;
fid = 56;
figure(fid);%clf;hold all
        
for gi = 1:length(gztype)
    gtype = gztype{gi};
    load([savpath gtype '_alldata.mat'])
    load([savpath gtype '_NSM_triggstat.mat'])
    
    tpre = 480; tpost = 480; % 4min pre
    dst = 30;
    tn = size(TD_on(1).vals,1); tl = length(TD_on);
    
    for ti = gzi{gi}%[55 62]%1:tn
        ctv = TD_on(11).vals(ti,:)/20000;
        ctvm = slidingmedian([],ctv,27,-1);
        for cdi = 1:10
            ci = corder(cdi);
            ctd = TD_on(ci).vals(ti,:);
            ctdm = slidingmedian([],ctd,smw,-1);
            
            subplot(tl,4,tp+4*(cdi-1)); cla;hold all
            colorline_general([ctvm .1],[tx tx(end)+.0001],[0.2 .8 0.2],[0.7 0 0],[-2 2])
            plot(tx,ctdm,'k','linewidth',1.5)
            plot([0 0],get(gca,'ylim'),'k:','linewidth',1.5)
            if cdi<11&&tp==1
                %title(cnmvec{ci})
            end
            xlim([-360 360]*.5); ylim([-.1 max(ctdm(240:end))+.1])
            plotstandard
            set(gca,'ytick',0:.5:2,'yticklabel','','ticklength',.05*[1 1],'xtick',-180:90:180)
        end
        tp = tp+1;
    end
end
% wtd: 3 (4)
% wt: 9 (22 28)
% wtf: (4 20 22)55 62
%%
load([savpath gtype '_alldata.mat'])
    load([savpath gtype '_NSM_triggstat_2.mat'])
    
    pfo = 420:480; prw = 540:600; pow = 630:690; pcp = nan(2,10);
for cdi = 1:10
            ci = corder(cdi);
            ctd = TD_on(ci).vals;
            cto = cal_matmean(ctd,1,1);
            ctm = slidingmedian([],cto.mean,smw,-1);
            ctl = slidingmedian([],cto.ci(1,:),smw,-1);
            cth = slidingmedian([],cto.ci(2,:),smw,-1);
            
            subplot(tl,4,4*(cdi));cla; hold all 
            plot_bci(tx,[ctl;cth],ctm,'k',[],[])
            xlim([-360 360]*.5); ylim([mean(ctm(240:960))-.3 max(ctm(240:960))+.3])
            plot([0 0],get(gca,'ylim'),'k:','linewidth',1.5)
            plotstandard
            set(gca,'ytick',0:.5:2,'yticklabel','','ticklength',.05*[1 1],'xtick',-180:90:180)

% compare pre post
prd = ctd(:,prw); pod = ctd(:,pfo);
[p,h] = ranksum(prd(:),pod(:));
pcp(1,cdi) = p;
prd = ctd(:,prw); pod = ctd(:,pow);
[p,h] = ranksum(prd(:),pod(:));
pcp(2,cdi) = p;
end
pcp
% fdr = mafdr(pcp)
set(gcf,'outerposition',[126 309 411 639])
%%
if svon
figure(fid)
savname = 'wt_nntrig';
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')

 savname = 'wt_trigprofex';
 save([savpath savname '.mat'],'pcp','gztype','gzi','TD_on')
end
