setsavpath

fpath = 'J:\Ca data\tph-1 MT5 122217\wm1009\';
ft = dir([fpath '*_inter.mat']);
load([fpath ft(1).name]);
ft2 = dir([fpath '*_inter_exp.mat']);
load([fpath ft2(1).name]);
svon = 0;
%% denoising
szc = 8; op = .5; fr = .6;
ci = 1;
ir1 = int_ser{ci}; il = length(ir1);
ig1 = int_ser_g{ci}; 
figure(51);clf;hold all; 
% transparentScatter((1*(1:il))',ir1(:),szc,op,'r')
% transparentScatter((1*(1:il))',ig1(:),szc,op,'g')
subplot 211;hold all; ylim([0 1200])
scatter(tstmp(:),ir1(:),[],[1 .7 .7],'.')
subplot 212;hold all; ylim([0 1200])
scatter(tstmp(:),ig1(:),[],[.56 1 .56],'.')

% median filter
ws = 11;
iid = find(~isnan(ir1));
irm = nan(1,il);
irm = slidingmedian([],ir1,ws,0);
irm = slidingmedian([],irm,ws,0);

iid = find(~isnan(ig1));
igm = nan(1,il);
igm = slidingmedian([],ig1,ws,0);
igm = slidingmedian([],igm,ws,0);

figure(51);hold all; 
subplot 211;hold all; ylim([0 1200])
plot(tstmp(:),irm(:),'color',[1 0 0])
plotstandard
set(gca,'xtick',0:600:il,'yticklabel','')
subplot 212;hold all; ylim([0 1200])
plot(tstmp(:)',igm(:),'color',[0 1 0])
plotstandard
set(gca,'xtick',0:600:il,'yticklabel','')
set(gcf,'outerposition',[235 245 413 467])

%% detrend
[~,ird] = detrnd([],irm,1); [~,igd] = detrnd([],igm,1);
figure(52);clf;hold all; 
subplot 211;hold all; ylim([0 1200])
plot(tstmp(:),irm(:),':','color',[1 0.6 0.6],'linewidth',1.5)
plot(tstmp(:),ird(:),'color',[1 0 0],'linewidth',1.5)
plotstandard
set(gca,'xtick',0:600:il,'yticklabel','')
subplot 212;hold all; ylim([0 1200])
plot(tstmp(:),igm(:),':','color',[0.5 1 0.5],'linewidth',1.5)
plot(tstmp(:),igd(:),'color',[0 1 0],'linewidth',1.5)
plotstandard
set(gca,'xtick',0:600:il,'yticklabel','')
set(gcf,'outerposition',[535 245 413 467])

%% ratiometric
vth = .085; vclrs = getvclrs;
vsm(vsm>vth) = vth; vsm(vsm<-vth) = -vth;

figure(53);clf;hold all
colorline_general([vsm vth],[catime catime(end)+.0001],vclrs{1},vclrs{2},[-.28 4])
hold all
irp = interp1(tstmp,ird,catime,'linear',1);
igp = interp1(tstmp,igd,catime,'linear',1);
icr = (igp./irp); icrn = (icr/prctile(icr,.25))-1;
plot(catime,icrn,'-','color','k','linewidth',1.5)
    set(gcf,'outerposition',[535 245 413 237])
plotstandard
set(gca,'ylim',[-.3 3.2],'xlim',tstmp([1 end]),'xtick',0:600:tstmp(end),'yticklabel','')

%% save plots
if svon
    %%
   for fi = 1:3
      figure(50+fi)
       savname = ['FS2_caproc_' num2str(fi)];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
   end    
end