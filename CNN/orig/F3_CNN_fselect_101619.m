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
%% train with leave-1-out data
aucal = struct('auc',[],'roc',[]);

for cti = cfull
    cls = cfull;
    cls(cls==cti) = [];
    
    [hfilt1,tacr1,sfm1,TDful,CTfull] = CNNscan(TDstat1,CTstat1,cls);
    %
    fnm = length(hfilt1); hwm1 = []; hclo1 = hwm1; hchi1 = hwm1;
    for hi = 1:numel(hfilt1{1}(:,:,1))
        [hwi,hwj] = ind2sub(size(hfilt1{1}(:,:,1)),hi);
        curh = cat(3,hfilt1{1}(hwi,hwj,:),hfilt1{2}(hwi,hwj,:));
        hwm1(hwi,hwj) = nanmean(curh);
        ctmp = prctile(curh(~isnan(curh)),[5 95]);
        hclo1(hwi,hwj) = ctmp(1);
        hchi1(hwi,hwj) = ctmp(2);
    end

    [aucf1,rocf1]=sumauc(sfm1);
    aucal(cti).auc = aucf1; aucal(cti).roc = rocf1;
    
    figure(101); clf; hold all
    subplot 121; ciplot(hclo1, hchi1); title('NSM on')
    plotstandard
    set(gcf,'outerposition',[50 812 576 202])
    
    saveas(gcf,[savpath2 gtype '_cnnpattern_ex' num2str(cti) '.tif'])
    
    hflt1.c(cti).fullex = hfilt1;
    hflt1.c(cti).fmex = hwm1;
    hflt1.c(cti).hiex = hchi1; hflt1.c(cti).loex = hclo1;
    hflt1.c(cti).acrex = tacr1;
end
%% quantify and compare accuracies
hst = struct('med',[],'ci',[]);
pclr = [ones(1,3)];
cp = 1; bbol = 0;
figure(105);clf;hold all
for cti = 1:10
    cac = hflt1.c(cti).acrex;
    hst.med(cti) = nanmean(cac);
    hst.ci(:,cti) = bootci(100,@nanmean,cac);
    if cti>1
        bci = [hst.ci(:,cti)]; bmn = [hst.med(cti)]; 
        subplot(10,1,cti); hold all
        plot([0 3],hst.ci(1,1)*ones(1,2),'k:','linewidth',1)
        plot([0 3],hst.ci(2,1)*ones(1,2),'k:','linewidth',1)
        plot_bcibar([],bci,bmn,pclr,5,'o',[],bbol)
        plotstandard
        ylim([.53 .73]); xlim([.75 1.25])
        set(gca,'yticklabel','')
    end
    cp = cp+1;
end


