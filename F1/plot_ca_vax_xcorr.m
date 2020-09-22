%% compute and plot sum stats

figure(3);clf;hold all

for ci = 1:cnum
    
    subplot(cnum,1,ci); hold all
    
    plot(lags,zeros(size(lags)),'k')
    plot([0 0],[-1 1],'k:')
    xlim([-30 30]); ylim([-.6 .6])
    
    if strcmp(gtype,'wt')
        %             errorbar(lags,mxa,cxa,'.','color','k')
        %             plot(lags,mxa,'k','linewidth',1.5)
        pclr = 'b';
    else
        pclr = [.65 0 .18];
    end
    
    plot_bci(lags,cci{ci},cmean{ci},pclr,[])
    
    plotstandard
    set(gca,'yticklabel','','ticklength',[.055 .055])
    
end
