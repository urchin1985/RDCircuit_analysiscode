load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
%% run directly if follow from TBSana5
trn = size(TD_on(1).vals,1);
cn = length(TD_on);

figure(29);clf;hold all

for ti = 1:trn
    if mod(ti,2)
        clf
    end
    for ci = 1:cn
        subplot(cn,2,2*(ci-1)+1); hold all
        plot(TD_on(ci).vals(ti,:))
        plot([601 601],get(gca,'ylim'),'k:')
        if ci<11
            title(cnmvec{ci})
        end
        
        subplot(cn,2,2*(ci)); hold all
        plot(TD_off(ci).vals(ti,:))
        plot([601 601],get(gca,'ylim'),'k:')
        ylim([-2000 2000])
    end
    
    [x,y] = ginput(1);
end