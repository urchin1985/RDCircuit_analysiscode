setsavpath
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};
cvc = {.2*ones(1,3),.9*[0 0 1]};
svon = 0;
foi = 27;

%%
gtype = 'gcy28ChN'; %'gcy28Chmful';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])

bnm = 50; dt = 30; pcp = nan(2,2);
corder = [1 11];
tn = size(TD_on(1).vals,1); tl = length(TD_on);
cl = length(corder);

fid = 55;
figure(fid);clf;hold all

dw = 5;smw = 3;
tx = (-600:dw:600)*.6;
pfo = 420:480; prw = 540:600; pow = 630:690; 

ci = 1; % NSM
ctd = (TD_on(ci).vals);
if ci == 11; ctd = ctd/20000; end
cto = cal_matmean_ds(ctd,1,dw,1);
ctm = slidingmedian([],cto.mean,smw,-1);
ctl = slidingmedian([],cto.ci(1,:),smw,-1);
cth = slidingmedian([],cto.ci(2,:),smw,-1);

subplot 211;cla; hold all
patch([0 60 60 0],[0 0 1 1],'r','facealpha',.35,'edgecolor','none')
plot_bci(tx,[ctl;cth],ctm,'k',[],[])
ylim([.25 .75]); xlim([-20 80])
plotstandard
set(gca,'ytick',0:.25:2,'yticklabel','','ticklength',.05*[1 1],...
    'xtick',[-20 0:30:80 80])

% compare pre post
prd = ctd(:,prw); pod = ctd(:,pfo);
[p,h] = ranksum(prd(:),pod(:));
pcp(1,1) = p;
prd = ctd(:,prw); pod = ctd(:,pow);
[p,h] = ranksum(prd(:),pod(:));
pcp(1,2) = p;

        
ci = 11; % speed
ctd = abs(TD_on(ci).vals);
if ci == 11; ctd = ctd/20000; end
cto = cal_matmean_ds(ctd,1,dw,1);
ctm = slidingmedian([],cto.mean,smw,-1);
ctl = slidingmedian([],cto.ci(1,:),smw,-1);
cth = slidingmedian([],cto.ci(2,:),smw,-1);

subplot 212;cla; hold all
patch([0 60 60 0],[0 0 1 1],'r','facealpha',.35,'edgecolor','none')
plot_bci(tx,[ctl;cth],ctm,'k',[],[])
ylim([.01 .07]); xlim([-20 80])
plotstandard
set(gca,'ytick',0:.02:.2,'yticklabel','','ticklength',.05*[1 1],...
    'xtick',[-20 0:30:80 80])

% compare pre post
prd = ctd(:,prw); pod = ctd(:,pfo);
[p,h] = ranksum(prd(:),pod(:));
pcp(2,1) = p;
prd = ctd(:,prw); pod = ctd(:,pow);
[p,h] = ranksum(prd(:),pod(:));
pcp(2,2) = p;
  
pfdr = mafdr(pcp(~isnan(pcp)),'BHFDR',true);
pfdr = reshape(pfdr,2,2)
set(gcf,'outerposition',[126 540 209 408])

%% save data for direct plotting
if svon
    figure(fid)
    savname = [gtype '_NSMspdresp'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '_optotranspca.fig'])
    saveas(gcf,[savpath2 savname '_optotranspca.eps'],'epsc')
    
    save([savpath savname '.mat'],'pfdr')
    
end