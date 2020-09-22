cnum = length(corder);
plnum = cnum;
pli = 1;

if ~exist('corder','var')
    corder = [1 4 2 3 5 6 7 8 9 10];
end

figure(125);clf;hold all
for ci = corder
    subplot(plnum,1,pli);cla;hold all
    
    colorline_general([vsm .1],[catime catime(length(catime))+.0001],[1 0 0],[0 0 1],[0 10])
    
    if exist('opinds','var')
        yt = zeros(size(catime)); yt(opcind) = 1.1;
        plot(catime,yt*10,'k','linewidth',1)
    end
    
    cdat = caexp_g{ci}; cdat = cdat/min(cdat)-1;
    plot(catime,cdat,'-','color',[0 .3 0],'linewidth',1.5)
    cmax = prctile(cdat,99.95);
    yrn = [0 ceil((ceil(cmax/.2)*.2)*10)/10];
    
    set(gca,'xtick',0:300:catime(end),'xticklabel',{'0','','10','','20','','30','','40','','50'},'xlim',...
        [catime(1) catime(end)],'tickdir','out','ticklength',[.015 .015],'fontsize',12,...
        'ytick',yrn,'ylim',yrn*1.1)
    yrange = yrn; %behpatch
    
    
    if ~isempty(cnames{ci})
        title(cnames{ci},'fontsize',10);
    else
        title(['Cell #' num2str(pli)],'fontsize',10)
    end
    
    if pli<plnum
        set(gca,'xticklabel','')
    end
    pli = pli+1;
    
end

subplot(plnum,1,plnum)
xlabel('Time (min)');


%     vex = prctile(abs(vsm),100);
% vex = vex;
%     vstr = sprintf('%0.1f',.1);
%     makecbar(vstr)
%     figure(10)
%     saveas(gcf,[datpath intfile(1:end-4) '_cbar.tif'])
% saveas(gcf,[datpath intfile(1:end-4) '_cvar.eps'],'epsc')