setsavpath
DirLog

cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

gtype = 'wtd2';
load([savpath gtype '_alldata.mat'])
svon = 0;
%% extract data
corder = [1 4 2 3 5 6 7 8 9 10];
vth = .085;
fids = Fdx==1;
cdata = Cdat(fids,:);
fidata = Fdx(fids);
catime = Tdat(fids);
catime = (0.6*(1:length(fidata)))';

vdata = Vdat(fids);
% btdata = Bst2(fids);
% bn = max(btdata);

plot_ca_prof_conly

if svon
    savname = [gtype '_ca_demotrans'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
end

% F1_nnca_bstat_bp