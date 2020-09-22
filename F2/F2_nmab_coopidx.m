
% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wt','tph1n','mod1','pdfr1','pdfracy1','tph1pdfr1'};
svon = 0;
%% NSM vs AVB activitiy histogram
clc
btn = 200;
fgl = length(fgtype); ocmat = cell(1,fgl); 
oco = nan(btn,fgl);

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
    vdata = Vdat(fids);
%     vlx = vax_clust(fids);
    cln = size(cdata,1);
   
    if fgi == 1
        xth = multithresh(cdata(:,1));
        yth = multithresh(cdata(:,4));
    end
   
    % bootstrap samples
    for bi = 1:btn
        cbx = datasample(1:cln,round(cln/4));
    % quantify occupancy
    o21 = sum(cdata(cbx,1)<xth&cdata(cbx,4)>yth);
    o22 = sum(cdata(cbx,1)>xth&cdata(cbx,4)>yth);
    o11 = sum(cdata(cbx,1)<xth&cdata(cbx,4)<yth);
    o12 = sum(cdata(cbx,1)>xth&cdata(cbx,4)<yth);
    omat = [o11 o12;o21 o22]; 
    ocmat{fgi} = omat/sum(omat(:));
    oco(bi,fgi) = o22/sum(omat(:));
    end
end
%%
[fdrp,rp] = multicomp_btwx(oco(:,2:end),oco(:,1))
omn = mean(oco,1); oci = prctile(oco,[2.5 97.5],1);
fiid = 69;
figure(fiid);clf;hold all
bw = []; bx = []; bbol = 1; msiz  = 10; mtp = [];
pclr = [.24*ones(1,3);.9 .5 .1;1 .8 .3;.1 0 .9;.5 .1 .56;0.8 .6 .8];
plot_bcibar(bx,oci,omn,pclr,msiz,mtp,bw,bbol)
plotstandard
set(gca,'xlim',[.3 6.7],'ylim',[0 .25],'ytick',0:.05:.25,'yticklabel','')
%%
figure(fiid)
% set(gcf,'outerposition',[-10.2000  618.6000  761.6000  170.4000])
if svon
    savname = ['wtmt_nmab_coop'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
    save([savpath savname '.mat'],'ocmat','oco','omn','oci',...
        'fdrp','rp','fgtype')
end
