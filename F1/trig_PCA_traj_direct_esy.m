load([savpath gtype '_statetrans_PCA_' num2str(dt) 's.mat'],'T_on','P_on','tpre','tpost','TP')
%% offload data
predat = TP.prepc; posdat = TP.pospc; preca = TP.preca; posca = TP.posca;
prm = TP.prem; pom = TP.posm;prc = TP.nsmpre; poc = TP.nsmpos;
pl = TP.pvals; 
if ~exist('foi','var')
    foi = 17;
end
%
pset = [predat posdat]; caset = [preca posca];

proi = [4 6 7 9 14 20];
proi = [4 14 20];
pctrj_plot2d_flex


%% save data for direct plotting
% % saveas(gcf,[savpath2 gtype '_statetranspca.tif'])
% % saveas(gcf,[savpath2 gtype '_statetranspca.fig'])
% % saveas(gcf,[savpath2 gtype '_statetranspca.eps'],'epsc')