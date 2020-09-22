fa = .27;
clear bym1 bym2 byc1 byc2

% 5-HT mut, spd during rm/dw
figure(fi2);clf;hold all
fpi = 1;
for fgi = [1 2 3] %length(fgtype)
bxr = [.85 1.15]+fpi-1; 
by1 = abs(bdful(fgi).st(1).bdur);
by2 = abs(bdful(fgi).st(2).bdur);
bym1(fpi) = nanmean(by1); bym2(fpi) = nanmean(by2);
byc1(:,fpi) = bootci(200,@nanmean,by1);
byc2(:,fpi) = bootci(200,@nanmean,by2);

bl = length(by1);
bx1 = bxr(1)+.3*rand(1,bl);
bl = length(by2);
bx2 = bxr(1)+.3*rand(1,bl);

scatter(bx1,by1,22,clrs(3,:),'filled','markerfacealpha',fa)
scatter(bx2,by2,22,clrs(1,:),'filled','markerfacealpha',fa)
fpi = fpi+1;
end

errorbar(1:length(bym1),bym1,bym1-byc1(1,:),byc1(2,:)-bym1,'.-','markersize',16,'color',[.85 .33 .01],'linewidth',1.5)
errorbar(1:length(bym1),bym2,bym2-byc2(1,:),byc2(2,:)-bym2,'.-','markersize',16,'color',clrs(1,:),'linewidth',1.5)

plotstandard
xlim([0.3 fpi-.3]); ylim([0 500])
% set(gca,'ytick',0:.04:.12,'yticklabel','','ticklength',.04*[1 1])
set(gcf,'outerposition',[62 234 172 229])

%% PDF muts
fa = .27;
clear bym1 bym2 byc1 byc2

% 5-HT mut, spd during rm/dw
figure(fi2+1);clf;hold all
fpi = 1;
for fgi = [1 4 5] %length(fgtype)
bxr = [.85 1.15]+fpi-1; 
by1 = abs(bdful(fgi).st(1).bdur);
by2 = abs(bdful(fgi).st(2).bdur);
bym1(fpi) = nanmean(by1); bym2(fpi) = nanmean(by2);
byc1(:,fpi) = bootci(200,@nanmean,by1);
byc2(:,fpi) = bootci(200,@nanmean,by2);

bl = length(by1);
bx1 = bxr(1)+.3*rand(1,bl);
bl = length(by2);
bx2 = bxr(1)+.3*rand(1,bl);

scatter(bx1,by1,22,clrs(3,:),'filled','markerfacealpha',fa)
scatter(bx2,by2,22,clrs(1,:),'filled','markerfacealpha',fa)
fpi = fpi+1;
end

errorbar(1:length(bym1),bym1,bym1-byc1(1,:),byc1(2,:)-bym1,'.-','markersize',16,'color',[.85 .33 .01],'linewidth',1.5)
errorbar(1:length(bym1),bym2,bym2-byc2(1,:),byc2(2,:)-bym2,'.-','markersize',16,'color',clrs(1,:),'linewidth',1.5)

plotstandard
xlim([0.25 fpi-.25]); ylim([0 500])
% set(gca,'ytick',0:.04:.12,'yticklabel','','ticklength',.04*[1 1])

set(gcf,'outerposition',[302 234 172 229])

if svon
        figure(fi2)
    savname = [fgtype{fgi} '_5HT_bdurstat'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')

    figure(fi2+1)
    savname = [fgtype{fgi} '_PDF_bdurstat'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
end