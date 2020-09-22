%% load data at different time resolutions
dtst = [2 10 20 40 60]/2; dtn = length(dtst);
for dti = 1:dtn
    dt = dtst(dti);
    load([savpath gtype '_statetrans_3nn_' num2str(dt) 's.mat'],'T_on','tpre','tpost','TP')
    pred{dti} = TP.prepc; posd{dti} = TP.pospc; prec{dti} = TP.preca; posc{dti} = TP.posca;
    prmst{dti}= TP.prem; pomst{dti} = TP.posm; prcst{dti} = TP.nsmpre; pocst{dti} = TP.nsmpos;
end

cnm = length(T_on); trn = size(T_on(1).vals,1);
prg = prn(1):pon(end);

foi = 29;
%%
figure(foi);clf;hold all
for tri = 13:tn
    clf; hold all
    % raw resolution
    for ci = 1:cnm
        subplot(cnm,dtn+1,(dtn+1)*(ci-1)+1); cla;hold all
        plot(T_on(ci).vals(tri,prg))
        plot(prn(end)*[1 1],get(gca,'ylim'),'k:')
        title(cnmvec{ci})
    end
    
    % binned resolutions
    
    for dti = 1:dtn
        
        ppc = [prec{dti}(tri,:) posc{dti}(tri,:)];
        for ci = 1:cnm
            subplot(cnm,dtn+1,(dtn+1)*(ci-1)+1+dti); cla; hold all
            ppy = [pred{dti}(tri,:,ci) posd{dti}(tri,:,ci)];
            ppx = 1:length(ppy);
            pid = find(~isnan(ppy)&~isnan(ppc));
            
            plot(ppx,ppy,'linewidth',1.5)
            scatter(ppx(pid),ppy(pid),18,ppc(pid),'filled')
            plot(size(pred{dti},2)*[1 1],get(gca,'ylim'),'k:')
        end
        ylabel([num2str(dtst(dti)) 's'])
    end
    
    reply = input('Same example? n-enter/y-any other key: ','s');
    
    if ~isempty(reply)
        savname = [savpath2 gtype '_statetrans3nn_multires_e' num2str(tri)];
        saveas(gcf,[savname '.tif'])
        
    end
end