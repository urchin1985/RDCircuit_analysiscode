clear
DirLog
setsavpath
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

gtype = 'wt';
%% First, plot sample dataset
load([savpath gtype '_ca_demo.mat'])
corder = [1 4 2 3 5 6 7 8 9 10];
plot_ca_prof
ylim([0 .4])
saveas(gcf,[savpath2 gtype '_ca_demoprof.tif'])
saveas(gcf,[savpath2 gtype '_ca_demoprof.fig'])
saveas(gcf,[savpath2 gtype '_ca_demoprof.eps'],'epsc')
%%
load([savpath gtype '_alldata.mat'])

if strcmp(gtype,'wt')
    fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
else
    fids = find(Fdx>0);
end

cdata = Cdat(fids,:);
% cdata = zscore(cdata,[],1);
fidata = Fdx(fids);
vdata = Vdat(fids);
vlx = vax_clust(fids);
vln = max(vlx);

%% loop through datasets, identify and collect segments of NSM on, off and transition periods
if ~isempty(dir([savpath gtype '_vax_triggstat.mat']))
    load([savpath gtype '_vax_triggstat.mat'])
else
    vax_trigger_only
    savfile = [savpath gtype '_vax_triggstat.mat'];
    if ~isempty(dir(savfile))
        save(savfile,'VTR','TDF_on','TDF_off','TD_on','TD_off','tid_on','tid_off','TWon','TWoff','TDdur','-append')
    else
        save(savfile,'VTR','TDF_on','TDF_off','TD_on','TD_off','tid_on','tid_off','TWon','TWoff')
    end
end

% plot triggered average for neural activity and axial speed
% NSM, AVB, AIY, RIB, RME, RIA, ASI, AIA, AVA
if sum(~isnan(TD_on(11).vals))
    corder = [1 4 2 3 5 6 7 8 9 10 11];
else
    corder = [1 4 2 3 5 6 7 8 9 10];
end

prng = 360:840; bn = 500; pnm = length(TD_on);
tln = .055; paf = .45; ylm = [.1 .5];

figure(111);clf; hold all
plottrigfull_doi
saveas(gcf,[savpath2 gtype '_vaxtrans_nn_f1.tif'])
saveas(gcf,[savpath2 gtype '_vaxtrans_nn_f1.fig'])
saveas(gcf,[savpath2 gtype '_vaxtrans_nn_f1.eps'],'epsc')
%% Next plot average crosscorr with axial velocity
if ~isempty(dir([savpath gtype '_vax_xcorr.mat']))
    load([savpath gtype '_vax_xcorr.mat'],'lags','xcfsum','cmean','cci')
    plot_ca_vax_xcorr
else
    ca_vax_xcorr
    save([savpath gtype '_vax_xcorr.mat'],'lags','xcfsum','cmean','cci')
end

saveas(gcf,[savpath2 gtype '_vax_xcorr_f1.tif'])
saveas(gcf,[savpath2 gtype '_vax_xcorr_f1.fig'])
saveas(gcf,[savpath2 gtype '_vax_xcorr_f1.eps'],'epsc')
%%
% saveas(gcf,[savpath(1:end-1) ' plots\' gtype '_trigtraces.tif'])
% saveas(gcf,[savpath(1:end-1) ' plots\' gtype '_trigtraces.eps'],'epsc')