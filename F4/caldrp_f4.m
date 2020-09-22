function [cher,chlt,chm] = caldrp_f4(chxful,tpts,plclr)
% parse input params
ylm = [-.15 .4];

if ~exist('plclr','var')||isempty(plclr)
    plclr = [0 0 1];
end
%% plot pre-state profile for combined track group
crn1 = (1:15)+tpts(1)*3; crn2 = (1:15)+tpts(2)*3;
cher = nanmean(chxful(:,crn1),2);
chlt = nanmean(chxful(:,crn2),2);
chm = [nanmean(cher) nanmean(chlt)];

hold all
plot([cher chlt]','o-','color',plclr)
plot(chm,'o-','color',plclr,'linewidth',1.5)
% xlim(bx([1 end])); ylim(ylm)

% set(gca,'xtick',[((1:180:721)-tpre-1)/3 40],'xticklabel',{'-2' '-1' '0'},...
%     'ytick',[-.2 0 .2 .4],'yticklabel','')
plotstandard
% set(gcf,'outerposition',[200 685 200 265])