% clear
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
%%
vwa = [-107.6 17.9]; % [-65.6 10.8]
gtype = 'wt';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
% fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
nlab = nsm_clust(fids);
vlab = vax_clust(fids);

cls = 1:10; %cls(cls == 4) = [];
pdat = cdata(:,cls);
dt = 60;

cvals = vdata;
% cvals = vlab;
cvals = cdata(:,1);

[pc,score,latent,explnd] = runPCA(pdat,0,0,cvals);
score = zscore(pdat)*pc;
smcore = [];
for pdi = 1:size(score,2)
    smcore(:,pdi) = smooth(score(:,pdi),31);
end
%%
figure(16);clf;hold all
% subplot(5,1,1:4);hold all
scatter3(smcore(:,1),smcore(:,2),smcore(:,6),15,cvals,'filled')
% scatter3(smcore(nlab==3,1),smcore(nlab==3,2),smcore(nlab==3,3),3,find(nlab==3))
view(gca,vwa); grid on
if prctile(cvals,5)<-.03
    caxis([-.1 .1])
else
    caxis([0 .6])
end
% zlim([-3 5]); xlim([-3 3]); ylim([-4 4])

xlabel('PC1');ylabel('PC2');zlabel('PC3');
colormap parula

%% crosscorrelation with axial velocity and speed
pn = length(pc);
pcxcfv = cell(1,pn); pcxcfp = cell(1,pn);

for fi=(unique(fidata))'
    dli = find(fidata==fi);
    
    for pci = 1:pn
        curx = smcore(dli,pci);
        cury = vdata(dli);
        inds = ~isnan(curx)&~isnan(cury);
        [xcf,lags] = crosscorr(curx(inds),cury(inds),120);
        pcxcfv{pci} = [pcxcfv{pci} xcf];
        
        cury = abs(vdata(dli));
        inds = ~isnan(curx)&~isnan(cury);
        [xcf,lags] = crosscorr(curx(inds),cury(inds),120);
        pcxcfp{pci} = [pcxcfp{pci} xcf];
    end
end

% compute mean and ci
XP = struct('cm1',[],'cci1',[],'cm2',[],'cci2',[]);
for pci = 1:pn
    % prob xcorr with vax
    cd1 = pcxcfv{pci};
    cm1 = nanmean(cd1,2);
    cci1 = nan(2,size(cd1,1));
    for pri = 1:size(cd1,1)
        cci1(:,pri) = bootci(100,@nanmean,cd1(pri,:));
    end

    
    % probe xcorr with axial sd
    cd1 = pcxcfp{pci};
    cm2 = nanmean(cd1,2);
    cci2 = nan(2,size(cd1,1));
    for pri = 1:size(cd1,1)
        cci2(:,pri) = bootci(100,@nanmean,cd1(pri,:));
    end

    XP(pci).cm1 = cm1; XP(pci).cci1 = cci1;
        XP(pci).cm2 = cm2; XP(pci).cci2 = cci2;

end
%% plot xcorr for all pcs
figure(21); clf; hold all
for pci = 1:pn
    subplot(2,pn,pci); hold all
    plot(lags,zeros(size(lags)),'k-')
    plot([0 0],[-1 1],'k:')
    plot_bci(lags',XP(pci).cci1,XP(pci).cm1,'b',[])
    
    
    subplot(2,pn,pci+pn); hold all
    plot(lags,zeros(size(lags)),'k-')
    plot([0 0],[-1 1],'k:')
    plot_bci(lags',XP(pci).cci2,XP(pci).cm2,'m',[])
    
end
subplot(2,pn,floor(pn/2)); plotstandard; title('Xcorr with axial velocity')
    xlim(lags([1 end])); ylim(.5*[-1 1]); set(gca,'xtick',[-120 -60 0 60 120],'xticklabel','')
subplot(2,pn,floor(pn/2)+pn); plotstandard; title('Xcorr with axial speed')
    xlim(lags([1 end])); ylim(.5*[-1 1]); set(gca,'xtick',[-120 -60 0 60 120],'xticklabel','')
%
savname = [savpath2 gtype '_pccorr'];
saveas(gcf,[savname '.tif'])
saveas(gcf,[savname '.fig'])
saveas(gcf,[savname '.eps'],'epsc')

%% plot xcorr for just the first 4 pcs, display mutual info for other PCs
figure(22); clf; hold all
clst = get(gca,'colororder');
clst = [1 0 0; 0 1 0; 0 0 1; .5 .5 .5];

for pci = 1:4
    subplot 121; hold all
    plot(lags,zeros(size(lags)),'k-')
    plot([0 0],[-1 1],'k:')
    plot_bci(lags,XP(pci).cci1,XP(pci).cm1,clst(pci,:),[])
    
    
    subplot 122; hold all
    plot(lags,zeros(size(lags)),'k-')
    plot([0 0],[-1 1],'k:')
    plot_bci(lags,XP(pci).cci2,XP(pci).cm2,clst(pci,:),[])
    
end
subplot 121; plotstandard; title('Xcorr with axial velocity')
    xlim(lags([1 end])); ylim(.6*[-1 1]); set(gca,'xtick',[-120 -60 0 60 120],'ytick',-1:.5:1,'xticklabel','')
subplot 122; plotstandard; title('Xcorr with axial speed')
    xlim(lags([1 end])); ylim(.6*[-1 1]); set(gca,'xtick',[-120 -60 0 60 120],'ytick',-1:.5:1,'xticklabel','')

%
savname = [savpath2 gtype '_pcxc'];
saveas(gcf,[savname '.tif'])
saveas(gcf,[savname '.fig'])
saveas(gcf,[savname '.eps'],'epsc')
