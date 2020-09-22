setsavpath
svon = 0 ;
% general params
gtlist = {'wt' 'tph1' 'pdfr1' 'tph1pdfr1' 'unc31' 'tdc1' 'ttx3unc103gf' 'mod1' 'gcy28Chm'};
cgtype = 'wt';

gtype = cgtype;
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSMon_trigdata_9.mat'],'TDstat','CTstat');
TDstat1 = TDstat; CTstat1 = CTstat;
load([savpath gtype '_NSMoff_trigdata_9.mat'],'TDstat','CTstat');
TDstat2 = TDstat; CTstat2 = CTstat;

% use full data first
cfull = 2:10;
cls = cfull;
%% train with authentic data
[hfilt1,tacr1,sfm1,TDful,CTfull] = CNNscan(TDstat1,CTstat1,cls);
%
fnm = length(hfilt1); hwm1 = []; hclo1 = hwm1; hchi1 = hwm1; 
for hi = 1:numel(hfilt1{1}(:,:,1))
%     for fi = 1:fnm
        [hwi,hwj] = ind2sub(size(hfilt1{1}(:,:,1)),hi);
        curh = cat(3,hfilt1{1}(hwi,hwj,:),hfilt1{2}(hwi,hwj,:));
        hwm1(hwi,hwj) = nanmean(curh);
        ctmp = prctile(curh(~isnan(curh)),[5 95]);
        hclo1(hwi,hwj) = ctmp(1);
        hchi1(hwi,hwj) = ctmp(2);
%     end
end
%
[aucf1,rocf1]=sumauc(sfm1);

figure(101); clf; hold all
subplot 121; ciplot(hclo1, hchi1); title('NSM on')
plotstandard
set(gcf,'outerposition',[50 812 576 202])
%% train with scrambled data
[hfilt_c,tacr_c,sfmc,TDfulc,CTfullc] = CNNscan_ctrl(TDstat1,CTstat1,cls);
%
fnm = length(hfilt_c); hwmc = []; hcloc = hwmc; hchic = hwmc; 
for hi = 1:numel(hfilt_c{1}(:,:,1))
%     for fi = 1:fnm
        [hwi,hwj] = ind2sub(size(hfilt_c{1}(:,:,1)),hi);
        curh = cat(3,hfilt1{1}(hwi,hwj,:),hfilt_c{2}(hwi,hwj,:));
        hwmc(hwi,hwj) = nanmean(curh);
        ctmp = prctile(curh(~isnan(curh)),[5 95]);
        hcloc(hwi,hwj) = ctmp(1);
        hchic(hwi,hwj) = ctmp(2);
%     end
end
%
[aucfc,rocfc]=sumauc(sfmc);

figure(101); hold all
subplot 122; ciplot(hcloc, hchic); title('Ctrl')
set(gcf,'outerposition',[50 812 576 202])

if svon
    figure(101);
    savname = [gtype '_cnnpat_' num2str(cls(1)) '-' num2str(cls(end))];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
    savname = [gtype '_cnnpat_' num2str(cls(1)) '-' num2str(cls(end)) 'dat'];
    save([savpath savname '.mat'],'tacr1','hfilt1','hfilt_c','hwm1','hwmc','hclo1','hchi1','hcloc','hchic')
end
%% quantify and compare test accuracies between auth and scrmb
% figure;hold all;subplot 211;hist(tacr1);subplot 212;hist(tacr_c)
aum1 = nanmean(aucf1);
auci1 = bootci(100,@nanmean,aucf1);

aumc = nanmean(aucfc);
aucic = bootci(100,@nanmean,aucfc);

bci = [auci1 aucic]; bmn = [aum1 aumc]; pclr = [.1 .1 1;1 1 1];
bbol = 1;
figure(102);clf;hold all
plot_bcibar([],bci,bmn,pclr,2,[],[],bbol)
plotstandard
set(gca,'ylim',[0 1],'xlim',[.25 2.75],'xtick',[1 2],'yticklabel','')
set(gcf,'outerposition',[57 530 126 220])

if svon
    figure(102);
    savname = [gtype '_cnn' num2str(cls(1)) '-' num2str(cls(end)) 'vsCtrl_rocauc'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
    save([savpath savname '.mat'],'aucf1','rocf1','aucfc','rocfc','aum1','auci1','aumc','aucic')
end