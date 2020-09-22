function [aucf,rocf]=sumaucn(sfm1)
aucf = nan(1,length(sfm1));
rocf = [];
for mi = 1:length(sfm1)
sfm = (sfm1(mi).sf(:,end))';
tlb = sfm1(mi).tlb';%[lb 1-lb]';
% [tpr,fpr,thresholds] = roc(tlb,sfm);
[X,Y,T,AUC] = perfcurve(tlb,sfm,1);
aucf(mi) = AUC;
rocf = [rocf;[X(:) Y(:)]];
% % figure(10)
% % plotroc(tlb,sfm)
% % tacr1(mi)
end
% figure(65);clf;hold all
% subplot 211; hist(mau1)