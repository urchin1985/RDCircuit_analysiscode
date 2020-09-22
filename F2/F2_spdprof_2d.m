
% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wtf','tph1n','mod1','pdfr1','pdfracy1','tph1pdfr1'};
svon = 0;
%% NSM vs AVB activitiy histogram
clc
btn = 100; fiid = 73;
fgl = length(fgtype); ocmat = cell(1,fgl);
clrs = getstateclr;
cx = -.0125:.005:.115;

figure(18);clf;hold all
for fgi = 1:length(fgtype)
        gtype = fgtype{fgi};
        load([savpath gtype '_alldata.mat'])

Xd = []; mw = 20;
for fi = (unique(Fdx))'%1:max(Fdx)
    di = find(Fdx == fi);
    vdata = Vdat(di)/20000;
    vdata = medfilt1(vdata,15); %medfilt1(vdata/prctile(vdata,99),15);
    xin = 1:length(vdata);
    yin = vdata;%/prctile(vdata,99);
    vmed = slidingmedian(xin,yin,mw,0);
    vvar = slidingvar(xin,yin,mw,0);
    
    Xd = [Xd; [(abs(vmed(:))) log(abs(vvar(:)))]];   
end
subplot(2,3,fgi);cla;hold all
histogram2(Xd(:,1),Xd(:,2),0:.0051:.1,-20:.5:-3,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
colormap jet
end
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
