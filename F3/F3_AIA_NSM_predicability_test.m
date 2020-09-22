DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath

gtype = 'wtf';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
%%
cls = [1:10];

fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
clxn = nsm_clust(fids);

%%
load([savpath gtype '_AIA_gmfit.mat'],'Xd','Fdx','clx','gmfit')
clxa = clx;
[~,ahi] = max(gmfit.mu(:,1));
[~,nhi] = max(nsm_gmfit(:,1));
%%
for fi = 13%unique(Fdx')
di = find(Fdx == fi);
cdat1 = Cdat(di,1);
cdat3 = Cdat(di,3);
ncl = clxn(di);
acl = clxa(di);

ahp = acl==ahi;
ap = regionprops(ahp,'Area','PixelIdxList');
apdur = cat(1,ap.Area);
clear apon
for ai = 1:length(ap)
    apon(ai) = ap(ai).PixelIdxList(1);
end
% filter for duration >100 bouts and record start time

% gather NSM peak start times
nstr = NTR(3,fi);

nhp = ncl==nhi;
np = regionprops(nhp,'Area','PixelIdxList');
npdur = cat(1,np.Area);
clear npon
for ai = 1:length(np)
    npon(ai) = np(ai).PixelIdxList(1);
end

figure(2);clf;hold all;plot(cdat1);plot(cdat3)

[apon;apdur']
[npon;npdur']
end

% find aia fullon segments, then find the start (or the peak) of aia activity within the segment,
% then check for nearest nsm on start. if deep in the middle of an nsm on
% bout (i.e. nsm on and >50s since nsm on started), ignore