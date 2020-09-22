load([savpath gtype '_statetrans_PCA_15s.mat'],'T_on',...
    'P_on','tpre','tpost','TP','dt')

%%
figure(100);clf;hold all
for i = 1:10
subplot(5,2,i); hold all
po = cal_matmean(P_on(i).vals,1,1);
plot_bci([],po.ci,po.mean,'b',[])
end

%%
tn = size(T_on(1).vals,1);
clear pdt
pdt(10).vals = [];
for ti = 1:tn
    tdt = []; 
    for ci = 1:10
        tdt = [tdt (T_on(ci).vals(ti,:))'];
    end
    % project to pc spacce
    tpc = zscore(tdt)*pc;
    for pi = 1:10
        pdt(pi).vals = [pdt(pi).vals;(tpc(:,pi))'];
    end
end

figure(102);clf;hold all
for i = 1:10
subplot(5,2,i); hold all
po = cal_matmean(pdt(i).vals,1,1);
plot_bci([],po.ci,po.mean,'b',[])
plot([240 240],[0 1],'k')
end
