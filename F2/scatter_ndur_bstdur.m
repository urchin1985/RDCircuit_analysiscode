px = [ndur{c1} ndur{c2}]; py = [bstdur{c1} bstdur{c2}];
lbl = [zeros(size(ndur{c1})) ones(size(ndur{c2}))];
h = scatterhist(px,py,'Group',lbl,'Kernel','on','Bandwidth',[bw*[1,1];bw*[1,1]],'legend','off',...
    'Direction','out','Color',[.6 .6 .6;0 0 .7],'marker','..','LineStyle',{'-','-',':'},...
    'LineWidth',[2,2,2],'MarkerSize',[12,12]);
% % xlabel('5-HT neuron ON duration (min)');ylabel('Dwelling duration (min)');
set(h(1),'xtick',0:240:2400,'ytick',0:240:2400,'xticklabel','',...
    'yticklabel','',...
    'tickdir','out','ticklength',.025*ones(1,2))
% {'0' '4' '6' '8','10'}
axis square

axes(h(1)); plotstandard
h(1).XLabel.String = '';
h(1).YLabel.String = '';

h(1).Position = [0.35 .35 .55 .55];
h(3).Position = [0.0326 0.3484 0.1570 .5532];
h(2).Position = [0.2461 0.0494 0.4577 0.1570];

set(gcf,'outerposition',[lx,ly,192.8 276])