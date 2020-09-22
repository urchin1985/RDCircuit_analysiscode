% clear
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath

gtype = 'wt';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
%%
cid = 3; cls = [1:10];

fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
clx = nsm_clust(fids);
cln = max(clx);

dti = 5; % use 30s res
tres = 300;
foi = 40;
coi = [3 8 9];
%% prepare peri-event datasets
tpre = 0; tpost = 90; % 2 min post
dst = 3;
cset = [3 8 9 1];
c1 = cset(4); c2 = cset(2);

varout = nsmtrigger_onflex(NTR,cdata,vdata,fidata,nsm_gmfit,tpre,tpost);
TD_on = varout.tdon;
CT_on = varout.cton;
cnm = length(TD_on);

% now downsample data in 10s increments
[~,TDs] = tddownsmpl(TD_on,dst); 
[~,CTs] = tddownsmpl(CT_on,dst);

% generate scatterhist plots
clr = getstateclr;
tn = size(TDs(1).vals,1); tl = size(TDs(1).vals,2);
cn = size(CTs(1).vals,1); cl = size(CTs(1).vals,2);

txcf = [];
for ti = 1:tn
    tcx = TDs(c1).vals(ti,:);
    tcy = TDs(c2).vals(ti,:);
    ki = ~isnan(tcx)&~isnan(tcy);
    if sum(ki)>10
    [xcf,lags] = crosscorr(tcx(ki),tcy(ki),30/dst);
    txcf = [txcf;xcf];
    end
end
tout = cal_matmean(txcf,1);

cxcf = [];
for ti = 1:tn
    ccx = CTs(c1).vals(ti,:);
    ccy = CTs(c2).vals(ti,:);
    ki = ~isnan(ccx)&~isnan(ccy);
    if sum(ki)>10
    [xcf,lags] = crosscorr(ccx,ccy,30/dst);
    cxcf = [cxcf;xcf];
    end
end

cout = cal_matmean(cxcf,1);
%
figure(40);clf;hold all
% plot(txcf','color',.5*ones(1,3))
plot_bci(lags,tout.ci,tout.mean,mean(clr([1 3],:)),[])

% plot(txcf','color',.5*ones(1,3))
plot_bci(lags,cout.ci,cout.mean,clr(1,:),[])

plot(lags([1 end]),[0 0],'k')
plot([0 0],[-1 1],'k:')
set(gca,'xlim',lags([1 end]),'ylim',[-.4 .7])