setsavpath
DirLog

cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};
corder = [1 4 2 3 5 6 7 8 9 10];

svon = 0;
%% display example traces from each stage
gtype = 'wt'; %  'wtd' 'wtf'
fzi = {[8]}; % rm->trans->dw
xrn = {[1980 2225],[745 985],[65 305]};
figure(61);clf;hold all

load([savpath gtype '_alldata.mat'])

coi = [9 8 3 4 1]; ch = 1.3;
yrnm = [0 length(coi)*ch+2.2];
clrs = getstateclr;
clset = {clrs(2,:),clrs(1,:)};
vclrs = getvclrs;
vth = .085;

for fi = 1:length(fzi)
    fdi = fzi{fi};
    fids = find(Fdx==fdi);
    cdata = Cdat(fids,:);
    fidata = Fdx(fids);
    catime = Tdat(fids);
    vdata = Vdat(fids);
    vsm = (medfilt1(vdata,23))/20000; % slidingmedian([],ctv,27,-1);
    vsm(vsm>vth) = vth; vsm(vsm<-vth) = -vth;
    btdata = Bst2(fids);btdata(4230:4509) = 1;
    
    subplot(1,3,fi); cla; hold all
    colorline_general([vsm' vth],[catime' catime(length(catime))-.0001]-10,...
        vclrs{1},vclrs{2},[-.5 yrnm(2)-2])
    generate_discts_patch(btdata',catime'-10,clset,[yrnm(2)-2 yrnm(2)-1.5],.7)

    for cdi = 1:length(coi)
        ci = coi(cdi);
        if fi==2&&ci==4; ci = 5; end
        cdat = cdata(:,ci);
        cmax = prctile(cdat(~isnan(cdat)),99.95);
        plot(catime,cdat+(cdi-1)*ch,'-','color','k','linewidth',1.5) % [0 .3 0]
    end
    
    xlm = xrn{fi};
    plotstandard
    
    dx = 120; 
    set(gca,'ytick',0:ch:7,'yticklabel','','ticklength',.035*[1 1],...
        'xtick',xlm(1):dx:xlm(2),'xlim',xlm,'ylim',[-.2 yrnm(2)-1.5])
    
end
%%
if svon
    figure(61)
    savname = 'wt_trnsex2';
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
end
