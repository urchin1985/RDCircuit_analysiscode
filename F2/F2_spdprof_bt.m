
% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wtf','tph1n','mod1','pdfr1','pdfracy1','tph1pdfr1'};
svon = 0;
%% NSM vs AVB activitiy histogram
clc
btn = 100; fiid = 75; bn = 100;
fgl = length(fgtype); ocmat = cell(1,fgl);
clrs = getstateclr;
cx = -.01:.005:.115;
hrn = [.02 .04]; pmmt = nan(bn,fgl);

for fgi = 1:fgl%[1 4 5 6]
    gtype = fgtype{fgi};
    load([savpath gtype '_alldata.mat'])
    if strcmp(gtype,'wtf')
        fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
        fids = find(Fdx>7|Fdx<2);
    elseif strcmp(gtype,'mod1')
        fids = find(Fdx<4);
    elseif strcmp(gtype,'pdfr1')
        fids = find(Fdx>1&Fdx<6);
    else
        fids = find(Fdx>0);
    end
    
    cdata = Cdat(fids,:);
    cdata(cdata==0) = nan;
    % cdata = zscore(cdata,[],1);
    fdata = Fdx(fids);
    vdata = Vdat(fids)/20000;
    bdata = Bst2(fids);
    if fgi==1; bdata = 2-bdata; end
    cln = size(cdata,1);
    
    for bi = 1:bn
        pid = datasample(1:cln,round(cln/4));
        pdt = abs(vdata(pid));
        pmd(bi,fgi) = sum(pdt>=hrn(1)&pdt<=hrn(2))/length(pdt);
    end
 end
pmci = prctile(pmd,[2.5 97.5]); pmn = mean(pmd);
[fdrp,rp] = multicomp_bt(pmd(:,2:end),pmd(:,1))
%% plotting
figure(fiid);clf;hold all
bw = []; bx = []; bbol = 1; msiz  = 10; mtp = [];
pclr = [.24*ones(1,3);.9 .5 .1;1 .8 .3;.1 0 .9;.5 .1 .56;0.8 .6 .8];
plot_bcibar(bx,pmci,pmn,pclr,msiz,mtp,bw,bbol)
plotstandard
set(gca,'xlim',[.3 6.7],'ylim',[0 .5],'ytick',0:.25:1,'yticklabel','')
setfigsiz([-10.2000  520.6000  306.6000  280.4000])

%%
if svon
    savname = ['wtmt_medsp_frctt'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
    save([savpath savname(1:(end-1)) '.mat'],'pmd','pmci','pmn',...
        'fdrp','rp','fgtype')
end
