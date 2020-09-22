cnum = size(cdata,2);
plnum = cnum;
pli = 1;
% clset = {[.93 .69 .13],[.49 .18 .56],[.4 .67 .19]};
clrs = getstateclr;
clset = {clrs(2,:),clrs(1,:)};
vclrs = getvclrs;
vsm = (medfilt1(vdata,33))/20000;
vsm(vsm>vth) = vth; vsm(vsm<-vth) = -vth;

figure(125);clf;hold all
for ci = corder
    cdat = cdata(:,ci); %cdat(cdat>1.2) = nan;
    cdat = smooth(cdat,17);
    cmax = prctile(cdat(~isnan(cdat)),99.95);
    
    subplot(plnum,1,pli);cla;hold all
    yrn = [-.1 min(2,ceil((ceil(cmax/.2)*.2)*10)/10)];
    
    colorline_general([vsm' vth],[catime' catime(length(catime))+.0001],...
        vclrs{1},vclrs{2},[-.5 yrn(2)+.4])
%     generate_discts_patch(btdata',catime',clset,[yrn(2)-.4 2.5],.7)
    
    plot(catime,cdat,'-','color','k','linewidth',1.5) % [0 .3 0]
    
    set(gca,'xtick',0:300:catime(end),'xticklabel',{'0','','10','','20','','30','','40','','50'},'xlim',...
        [catime(1) catime(end)],'tickdir','out','ticklength',[.015 .015],'fontsize',12,...
        'ytick',[0 1],'ylim',yrn*1.1)
    set(gca,'yticklabel','','xticklabel','')
    yrange = yrn; %behpatch
    
    xlim([1000 1554])
    title(cnmvec{ci},'fontsize',10);
    set(gcf,'outerposition',[163 42 500 782])
    
    if pli<plnum
        set(gca,'xticklabel','')
    end
    pli = pli+1;
    
end

subplot(plnum,1,plnum)
% xlabel('Time (min)');


%     vex = prctile(abs(vsm),100);
% vex = vex;
%     vstr = sprintf('%0.1f',.1);
%     makecbar(vstr)
%     figure(10)
%     saveas(gcf,[datpath intfile(1:end-4) '_cbar.tif'])
% saveas(gcf,[datpath intfile(1:end-4) '_cvar.eps'],'epsc')