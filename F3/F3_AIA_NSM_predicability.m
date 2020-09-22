DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
%%
gtype = 'wt';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
%
cls = [1:10];

fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
clxn = nsm_clust(fids);

load([savpath 'wtf_AIA_gmfit.mat'],'Xd','Fdx','clx','gmfit')
coi = 8;
prepXd
clx = cluster(gmfit,Xd(:,1:2));
clxa = clx;

figure(1);clf;hold all
subplot 211;
nn_pkdist
npk{1} = andful;
%%
gtype = 'tph1i';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
%
cls = [1:10];

fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
clxn = nsm_clust(fids);

% load([savpath 'wtf_AIA_gmfit.mat'],'gmfit')
coi = 8;
prepXd
clx = cluster(gmfit,Xd(:,1:2));
clxa = clx;

figure(1);hold all
subplot 212;
nn_pkdist

npk{2} = andful;
