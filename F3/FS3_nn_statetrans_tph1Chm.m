setsavpath
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};
cvc = {.2*ones(1,3),.9*[0 0 1]};
svon = 0;
%%
gtype = 'tph1Chm'; %'gcy28Chmful';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])

corder = [4 2 3 5 6 7 8 9 10 11]; cl = length(corder);

bnm = 50; dt = 30; pcp = nan(cl,2);
tn = size(TD_on(1).vals,1); tl = length(TD_on);
cl = length(corder);

fid = 56;
figure(fid);clf;hold all

dw = 5;smw = 6;
tx = (-600:dw:600)*.6;
pfo = 420:480; prw = 540:600; pow = 630:690;

for cid = 1:length(corder)
    ci = corder(cid);
    ctd = abs(TD_on(ci).vals);
    if ci == 11; ctd = ctd/20000; end
    cto = cal_matmean_ds(ctd,1,dw,1);
    ctm = slidingmedian([],cto.mean,smw,-1);
    ctl = slidingmedian([],cto.ci(1,:),smw,-1);
    cth = slidingmedian([],cto.ci(2,:),smw,-1);
    
    subplot(cl,1,cid);cla; hold all
    patch([0 60 60 0],[0 0 1 1],'r','facealpha',.35,'edgecolor','none')
    plot_bci(tx,[ctl;cth],ctm,'k',[],[])
    plotstandard
    
    if ci~=11
        ylim([.25 .75]); xlim([-30 120])
        set(gca,'ytick',0:.25:2,'yticklabel','','ticklength',.05*[1 1],...
            'xtick',[-20 0:30:120])
    else
        ylim([.025 .0751]); xlim([-30 120])
        set(gca,'ytick',0:.025:.2,'yticklabel','','ticklength',.05*[1 1],...
            'xtick',[-20 0:30:120])
    end
    
    % compare pre post
    prd = ctd(:,prw); pod = ctd(:,pfo);
    [p,h] = ranksum(prd(:),pod(:));
    pcp(cid,1) = p;
    prd = ctd(:,prw); pod = ctd(:,pow);
    [p,h] = ranksum(prd(:),pod(:));
    pcp(cid,2) = p;
   
end
    
    pfdr = mafdr(pcp(~isnan(pcp)),'BHFDR',true);
    pfdr = reshape(pfdr,cl,2)
    set(gcf,'outerposition',[126 540 209 1028])
%% save data for direct plotting
if svon
    figure(fid)
    savname = [gtype '_nnspdresp'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '_optotranspca.fig'])
    saveas(gcf,[savpath2 savname '_optotranspca.eps'],'epsc')
    
    save([savpath savname '.mat'],'pfdr','pcp')
end