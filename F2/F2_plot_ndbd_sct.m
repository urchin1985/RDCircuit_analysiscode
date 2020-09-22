cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wtf','tph1','mod1','pdfr1','tph1pdfr1','tph1i','pdfracy1'};
cid = 3; % 3~NSM high periods
bid = 3;
svon = 0;
%%
% load([savpath 'wt_mt_nsmdwdur_schist.mat'],'ndur','bstdur','nfdr','bfdr')
fi1 = 40;
fa = .27;
eclrs = [0 0 .3;.9 .7 .2;.3 .6 .1];
bn = 200;

clear bym1 bym2 byc1 byc2

% 5-HT mut, nsm on duration
figure(fi1);clf;hold all
fpi = 1;
for fgi = [1 2 3] %length(fgtype)
by1 = ndur{fgi};
by2 = bstdur{fgi};
[mn1,bci1] = calc_mnbci(by1,bn);
bym1(fpi) = mn1; 
byc1(:,fpi) = bci1;

[mn2,bci2] = calc_mnbci(by2,bn);
bym2(fpi) = mn2;
byc2(:,fpi) = bci2;

subplot 211; hold all
eh = errorbar(mn1,mn2,mn2-bci2(1),bci2(2)-mn2,mn1-bci1(1),bci1(2)-mn1,'o','color',eclrs(fpi,:),'markerfacecolor',eclrs(fpi,:),'linewidth',1);
fpi = fpi+1;
end
plot([0 800],[0 800],'k:')
xlim([-10 500]); ylim([-10 500])
plotstandard
set(gca,'ytick',0:240:600,'xtick',0:240:600,'yticklabel','')
axis square
%% PDF muts
clear bym1 bym2 byc1 byc2
eclrs = [0 0 .3;.5 .1 .56;1 .2 .8];

subplot 212; cla;
fpi = 1;
for fgi = [1 4 7] %length(fgtype)
by1 = ndur{fgi};
by2 = bstdur{fgi};
[mn1,bci1] = calc_mnbci(by1,bn);
bym1(fpi) = mn1; 
byc1(:,fpi) = bci1;

[mn2,bci2] = calc_mnbci(by2,bn);
bym2(fpi) = mn2;
byc2(:,fpi) = bci2;

subplot 212; hold all
eh = errorbar(mn1,mn2,mn2-bci2(1),bci2(2)-mn2,mn1-bci1(1),bci1(2)-mn1,'o','color',eclrs(fpi,:),'markerfacecolor',eclrs(fpi,:),'linewidth',1);
fpi = fpi+1;
end
plot([0 1000],[0 1000],'k:')
xlim([-10 1050]); ylim([-10 500])
plotstandard
set(gca,'ytick',0:240:1000,'xtick',0:240:1000,'yticklabel','')
axis square

if svon
    dfname = ['wtmt_ndurbdur_scplt'];
    saveas(gcf,[savpath2 dfname '.tif'])
    saveas(gcf,[savpath2 dfname '.fig'])
    saveas(gcf,[savpath2 dfname '.eps'],'epsc')
end

%% plot spd per state
clear bym1 bym2 byc1 byc2

load([savpath 'wt_mt_bvbdstat.mat'],'bvful','fgtype')

eclrs = [0 0 .3;.9 .7 .2;.5 .1 .56];
figure(fpi+1);clf; hold all
fpi = 1;
for fgi = [1 3 4] %length(fgtype)
by1 = abs(bvful(fgi).st(1).bvm)/20000;
by2 = abs(bvful(fgi).st(2).bvm)/20000;
[mn1,bci1] = calc_mnbci(by1,bn);
bym1(fpi) = mn1; 
byc1(:,fpi) = bci1;

[mn2,bci2] = calc_mnbci(by2,bn);
bym2(fpi) = mn2;
byc2(:,fpi) = bci2;

fpi = fpi+1;
end

ebar2d(bym1,bym2,[],[],byc1,byc2,eclrs)

plot([-1 1],[-1 1],'k:')
xlim([-.005 .05]); ylim([-.005 .05])
plotstandard
set(gca,'ytick',0:240:1000,'xtick',0:240:1000,'yticklabel','')
axis square