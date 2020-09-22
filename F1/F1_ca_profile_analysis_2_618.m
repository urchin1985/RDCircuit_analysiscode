setsavpath
DirLog

cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

gtype = 'wt';
load([savpath gtype '_alldata.mat'])
svon = 0;
%% extract data
corder = [1 4 2 3 5 6 7 8 9 10];
vth = .085;
fids = Fdx==12; % wt12
cdata = Cdat(fids,:);
fidata = Fdx(fids);
cat1 = td1(fids); 
vdata = Vdat(fids);
btdata = Bst2(fids);
bn = max(btdata);

plot_ca_prof_3

if svon
    savname = [gtype '_ca_demoorg'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
end

% F1_nnca_bstat_bp