cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wtf','tph1','mod1','pdfr1','tph1pdfr1','tph1i','pdfracy1'};
cid = 3; % 3~NSM high periods
bid = 3;
svon = 0;
%%
load([savpath 'wt_mt_nsmdwdur_schist.mat'],'ndur','bstdur','nfdr','bfdr')
fi1 = 40;
fa = .27;
eclrs = [.24*ones(1,3);.9 .5 .1;1 .8 .3];
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

fpi = fpi+1;
end

subplot 211; hold all
plot_bcibar([],byc1,bym1,eclrs,[],[],.6,1)

ylim([0 500]); xlim([.3 fpi-.3])
plotstandard
set(gca,'ytick',0:240:600,'xtick',0:3,'yticklabel','')
axis square
%% PDF muts
clear bym1 bym2 byc1 byc2
eclrs = [.24*ones(1,3);.1 0 .9;.5 .1 .56;];

subplot 212; cla;
fpi = 1;
for fgi = [1 4 7 5] %length(fgtype)
by1 = ndur{fgi};
by2 = bstdur{fgi};
[mn1,bci1] = calc_mnbci(by1,bn);
bym1(fpi) = mn1; 
byc1(:,fpi) = bci1;

[mn2,bci2] = calc_mnbci(by2,bn);
bym2(fpi) = mn2;
byc2(:,fpi) = bci2;

fpi = fpi+1;
end

subplot 212; hold all
plot_bcibar([],byc1,bym1,eclrs,1,[],.6,1)
ylim([0 1100]); xlim([.3 fpi-.3])
plotstandard
set(gca,'ytick',0:240:1000,'xtick',0:5,'yticklabel','')
axis square
set(gcf,'outerposition',[327 469 136 422])

if svon
    dfname = ['wtmt_ndur_bplt'];
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