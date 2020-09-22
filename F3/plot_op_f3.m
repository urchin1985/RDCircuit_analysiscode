if ~exist('ord','var')
    ord = 1:size(ozmat,1);
end

plot_bci([],opm.ci,opm.mean,pclr,[],[])
set(gca,'ylim',[0.01 0.15])
% ylim([0.05 .052])
yrn = get(gca,'ylim');
plot([10 70;10 70]*3,[yrn' yrn'],'k:','linewidth',1.5)
set(gca,'xlim',[0 size(opmat,2)])
