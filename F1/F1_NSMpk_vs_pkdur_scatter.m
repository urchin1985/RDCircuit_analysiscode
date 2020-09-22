cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wt','tph1','mod1','pdfr1','tph1pdfr1'};
vadur = cell(1,4); ndur = vadur;
cid = 3; % 3~NSM high periods
vid = 1;
%% extract transition period data and project onto PC space as defined by wild type
vadur = cell(1,4); ndur = vadur;
ci = 1;
gtype = 'wt';
load([savpath gtype '_alldata_1019.mat'])
load([savpath gtype '_NSM_triggstat_1019.mat'])
if strcmp(gtype,'wt')
    fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
else
    fids = find(Fdx>0);
end

extract_ndur_vdur
%%
ci = 2;
gtype = fgtype{ci};
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
fids = find(Fdx>0);

extract_ndur_vdur
%%
ci = 3;
gtype = fgtype{ci};
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
fids = find(Fdx>0);

extract_ndur_vdur
%%
ci = 4; ndur{ci} = []; vadur{ci}=[];
gtype = fgtype{ci};
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
fids = find(Fdx>0);

extract_ndur_vdur

%%
ci = 5; ndur{ci} = []; vadur{ci}=[];
gtype = fgtype{ci};
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
fids = find(Fdx>0);

extract_ndur_vdur

%%
c1 = 1; ffi = 22;
for fgi = 2:length(fgtype)
figure(ffi+fgi-2);clf;hold all;colormap jet
c2 = fgi;
scatter_ndur_vdur

% save data for direct plotting
savname = ['wt_' fgtype{fgi} '_nsmdwelldur_scatter'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '_optotranspca.fig'])
saveas(gcf,[savpath2 savname '_optotranspca.eps'],'epsc')

end

savname = 'wt_mt_nsmdwelldur_scatter';
save([savpath savname '.mat'],'ndur','vadur','fgtype')