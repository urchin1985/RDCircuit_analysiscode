setsavpath
DirLog

cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};
svon = 0;
%% extract data
gtype = 'pdfracy1';
load([savpath gtype '_alldata.mat'])

corder = [1 4 2 3 5 6 7 8 9 10];
if strcmp(gtype,'tph1')
    dmfi = 2; % 4 1
elseif strcmp(gtype,'pdfr1')
    dmfi = 4;
elseif strcmp(gtype,'mod1')
dmfi = 3; % 4
elseif strcmp(gtype,'pdfracy1')
dmfi = 3;
elseif strcmp(gtype,'tph1pdfr1')
dmfi = 1;
end

fids = Fdx==dmfi;
cdata = Cdat(fids,:);
fidata = Fdx(fids);
catime = Tdat(fids);
vdata = Vdat(fids);
btdata = Bst2(fids);
bn = max(btdata);
vth = .085;

plot_ca_prof_3

if svon
    svname = [gtype '_ca_demoproff_3'];
    saveas(gcf,[savpath2 svname '.tif']);
    saveas(gcf,[savpath2 svname '.fig'])
    saveas(gcf,[savpath2 svname '.eps'],'epsc')
end