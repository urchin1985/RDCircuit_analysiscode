
% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wt','tph1','mod1','pdfr1','pdfracy1','tph1pdfr1'};
svon = 0;
%% NSM vs AVB activitiy histogram
clc
btn = 100; fiid = 73;
fgl = length(fgtype); 
Inm = nan(1,fgl); Iab = Inm; Ina = Inm;
clrs = getstateclr;
cx = -.0125:.005:.125;hn = 45;

figure(fiid);clf;hold all
for fgi = 1:length(fgtype)
    gtype = fgtype{fgi};
    load([savpath gtype '_alldata.mat'])
    if strcmp(gtype,'wt')
        fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
    else
        fids = find(Fdx>0);
    end
    
    cdata = Cdat(fids,:);
    cdata(cdata==0) = nan;
    % cdata = zscore(cdata,[],1);
    fdata = Fdx(fids);
    vdata = Vdat(fids)/20000;
    bdata = Bst2(fids);
    %     vlx = vax_clust(fids);
    cln = size(cdata,1);
    
    pid = vdata>=-.5005;
    nmt = cdata(pid,1); abt = cdata(pid,4); pdt = abs(vdata(pid)); 
    figure(1); hh = make2dhist(nmt,pdt,hn); hxy = hh.Values/sum(hh.Values(:));
    Inm(fgi) = mutinf(hxy);
    figure(1); hh = make2dhist(abt,pdt,hn); hxy = hh.Values/sum(hh.Values(:));
    Iab(fgi) = mutinf(hxy);
    figure(1); hh = make2dhist(abt,nmt,hn); hxy = hh.Values/sum(hh.Values(:));
    Ina(fgi) = mutinf(hxy);
end
[Inm;Iab;Ina]
%%
figure(fiid)
set(gcf,'outerposition',[-10.2000  618.6000  761.6000  170.4000])
if svon
    savname = ['wtmt_nmab_coop'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
    save([savpath savname(1:(end-1)) '.mat'],'ocmat','oco','omn','oci',...
        'fdrp','rp','fgtype')
end
