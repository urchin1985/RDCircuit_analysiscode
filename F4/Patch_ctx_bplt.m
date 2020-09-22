setsavpath

set_gdirs

gztype = {'wt','wtld'};
% gztype = {'aiaunc','aiald'

%% combine data based on genotype and make plots
pclr = {.24*[1 1 1],.6*[1 1 1]};
mw = 20; dtst = [500 650]; fst = 20; ds = 20; dx = 50;
chrm = nan(length(gztype),2); chrel = chrm; chreh = chrm; chz = chrm;
ops = statset('UseParallel',true); clrs = getstateclr;

for gi = 1:length(gztype)
    dth = dtst(gi);
    go = load([bpath gtype{gi} '_fuldata.mat']);
    xgt = go.xgt;
        
    toi = 1;
    state_trigg_gen
    chdat2 = [cxmat1(stmat1==2&dsmat1<dth) cxmat2(stmat2==2&dsmat2<dth)]; % ctx during roaming
    chdat1 = [cxmat1(stmat1==1&dsmat1<dth) cxmat2(stmat2==1&dsmat2<dth)]; % during dwelling
    
    % compute and compare overall chemotaxis bias across genotypes
    cmn1 = nanmean(chdat1);
    cl1 = length(chdat1);
    cse1 = nanstd(chdat1)/sqrt(length(chdat1));
%     cci1 = bootci(100,{@nanmean,chdat1(randperm(cl1,round(.05*cl1)))},'Options',ops);
cci1 = bootlrg(chdat1,'mean',.1,100);

    cmn2 = nanmean(chdat2);
    cl2 = length(chdat2);
    cse2 = nanstd(chdat2)/sqrt(length(chdat2));
%     cci2 = bootci(100,{@nanmean,chdat2(randperm(cl2,round(.05*cl2)))},'Options',ops);
    cci2 = bootlrg(chdat2,'mean',.1,100); 
    
    chrm(gi,:) = [cmn2;cmn1];
    chz(gi,:) = [cl2;cl1];
    chrel(gi,:) = [cmn2-cci2(1);cmn1-cci1(1)];
    chreh(gi,:) = [cci2(2)-cmn2;cci1(2)-cmn1];
    chre(gi,:) = [cse2;cse1];
end
%%
bwh = .5;
bclr = [clrs(1,:);.6*ones(1,3);clrs(3,:);.6*ones(1,3)];
bx = [.65 1.35 2.65 3.35];
figure(36);clf;hold all
for bi = 1:numel(chrm)
bar(bx(bi),chrm(bi),'facecolor',bclr(bi,:),'barwidth',bwh);
errorbar(bx(bi),chrm(bi),chrel(bi),chreh(bi),'k.','linewidth',1)

end
plotstandard
set(gca,'yticklabel','','xlim',[0 4],'ylim',[-.01 .12])
set(gcf,'outerposition',[73 750 190 220])

if svon
savname = 'WTvLD_ctx';
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
end
saveas(gcf,[savpath2 savname '.eps'],'epsc')