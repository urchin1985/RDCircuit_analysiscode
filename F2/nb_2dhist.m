if ~exist('ln','var')
    ln = 3;
end

% scatterhist plot of NSM vs AVB activity
% scatter(cdata(idx,1),cdata(idx,4),15,abs(vdata(idx)/20000),'filled','markerfacealpha',.15);caxis([0 .1]);
% h = schist_fun(xset,yset,cset,bwth);
%% 
% axes(h(1)); hold all
colormap parula
xeds = -.1:.05:1.1; yeds = xeds;
[xm,ym] = meshgrid(xeds(2:end),yeds(2:end));

% % xtp = -3:10; ytp = xtp;  
% % [xmt,ymt] = meshgrid(xtp,ytp);
% % ntp = zeros(size(xmt));ntp(5,5)=.015;
% % pp = pcolor(xmt,ymt,ntp);
% % pp.LineStyle = 'none';
% %
[N,Xeds,Yeds] = histcounts2(xset{2},yset{2},xeds,yeds);
N = N/sum(N(:)); N(N<0.00007) = 0;
ph = pcolor(xm,ym,N');
ph.LineStyle = 'none';
hold all
caxis([0 .0007])
%%
xeds = -.1:.075:1.1; yeds = xeds;
[xm,ym] = meshgrid(xeds(2:end),yeds(2:end));
[N,Xeds,Yeds] = histcounts2(xset{2},yset{2},xeds,yeds);
% 
[~,hc] = contour(xm,ym,N',ln,'linecolor','k','levelstep',.25,'levelstepmode','manual',...
    'linewidth',1.5,'linestyle',':');  shading flat
caxis([0 .01])

set(gca,'xlim',[Xeds(1)/2 Xeds(end)],'ylim',[Yeds(1)/2 Yeds(end)],...
    'xtick',0:.5:1,'ytick',0:.5:1,'tickdir','out','ticklength',.025*[1 1])
axis square
set(gcf,'outerposition',[31+230*(fgi-1) 350 190 260])