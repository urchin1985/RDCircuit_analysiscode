%%
cnum = size(cdata,2);
xcfsum = cell(1,cnum);
for fi = (unique(fidata))'
    cvax = vdata(fidata == fi);
    cca = cdata(fidata == fi,:);
    
    %         vsm = (medfilt1(vaxintp,13))/20000;
    
    for ci = 1:cnum
        inds = ~isnan(cca(:,ci))&~isnan(cvax);
        [xcf,lags] = crosscorr(cca(inds,ci),cvax(inds),30);
        xcfsum{ci} = [xcfsum{ci};xcf'];
        
    end
end

%% compute and plot sum stats

figure(3);clf;hold all

for ci = 1:cnum
    xdat = xcfsum{ci};
    if ~isempty(xdat)
        mxa = [];
        for xi = 1:size(xdat,2)
            xa = xdat(:,xi); xa = xa(~isnan(xa));
            mxa(xi) = mean(xa);
            cxa(:,xi) = bootci(100,@mean,xa);
        end
        
        cmean{ci} = mxa;
        cci{ci} = cxa;
        
        subplot(cnum,1,ci); hold all
        
        plot(lags,zeros(size(lags)),'k-')
        plot([0 0],[-1 1],'k:')
        xlim([-30 30]); ylim([-.6 .6])
        
        if strcmp(gtype,'wt')
%             errorbar(lags,mxa,cxa,'.','color','k')
%             plot(lags,mxa,'k','linewidth',1.5)
        pclr = 'b';
        else
          pclr = [.65 0 .18];
        end
        
        plot_bci(lags,cxa,mxa,pclr,[])
        
        plotstandard
        set(gca,'yticklabel','')
    end
end
