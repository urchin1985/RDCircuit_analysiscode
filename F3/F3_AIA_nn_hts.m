% clear
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath

gtype = 'wt';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])

svon = 0;
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
%% prepare peri-event datasets
tpre = 480; tpost = 240; % 4min pre 1 min post
dst = 30;

varout = nsmtrigger_onflex(NTR,cdata,vdata,fidata,nsm_gmfit,tpre,tpost);
TD_on = varout.tdon;
CT_on = varout.cton;
cnm = length(TD_on);

% now downsample data in 10s increments
[~,TDs] = tddownsmpl(TD_on,dst);
[~,CTs] = tddownsmpl(CT_on,dst);

% group data into 3 windows 1-30s, 90-120, 150-180, make sure to exclude 0s
% before calc stats
tsl = size(TDs(1).vals,2);
woi = {(13:16),18:20};%{1:2,tsl-1:tsl};
clear tdgp
tdgp(cnm) = struct('gp',struct('dat',[]));
for wi = 1:length(woi)
    for ci = 1:cnm
        TDs(ci).vals(TDs(ci).vals==0) = nan;
        %         CTs(ci).vals(CTs(ci).vals==0) = nan;
        ttmp = TDs(ci).vals(:,woi{wi});
        ttmp(ttmp==0) = nan;
        tdgp(ci).gp(wi).dat = ttmp;
    end
end

% generate scatterhist plots
cset = [1 4 3 8 9];
crg = 8:19;% round(tsl/2):tsl;
clr = [0 0 1];

nnhist_ts

%% save plots
if svon
    %%
    figure(18)
    savname = [gtype '_' cnmvec{c1} 'vs_' cnmvec{c2} '_sttrans_sch'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
    figure(19)
    savname = [gtype '_' cnmvec{c1} 'vs_' cnmvec{c2} '_sttrans_sctfit'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
end