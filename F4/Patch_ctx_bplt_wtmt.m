setsavpath

set_gdirs

gtype = {'wt','aiaunc','pdfr1','tax4','tph1'};
svon = 0;
%% combine data based on genotype and make plots
% pclr = {.24*[1 1 1],.5*[0 1 0],[1 .6 .78],[.64 .08 .18]};
pclr = {.14*[1 1 1],.5*[0 1 0],[0 0 1],[.64 .08 .18],[.85 .5 0]};

mw = 20; dtst = [650 650 650 750 650]; fst = 20; ds = 20; dx = 50;
chrm = nan(length(gtype),2); chrel = chrm; chreh = chrm; chz = chrm;
ops = statset('UseParallel',true); clrs = getstateclr;
bx = [.65 1.35 2.25 3]; bwh = .5;

fi1 = 45;fi2 = fi1+1;
for gi = 1:length(gtype)
    dth = dtst(gi);
    go = load([bpath gtype{gi} '_fuldata.mat']);
    xgt = go.xgt;
    
    toi = 1;
    state_trigg_gen_spl
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
    
    if gi == 1
        wchm = [cmn2 cmn1]; wchrl = [cmn2-cci2(1) cmn1-cci1(1)];
        wchrh = [cci2(2)-cmn2 cci1(2)-cmn1]; wchre = [cse2 cse1];
    end
    
    chrm = [cmn2 wchm(1) cmn1 wchm(2)];
    chrel = [cmn2-cci2(1) wchrl(1) cmn1-cci1(1) wchrl(2)];
    chreh = [cci2(2)-cmn2 wchrh(1) cci1(2)-cmn1 wchrh(2)];
    chre = [cse2 wchre(1) cse1 wchre(2)];
    
    if gi>1
        bclr = [pclr{gi};.24*ones(1,3);pclr{gi};.24*ones(1,3)];
        figure(fi2+max(0,gi-2)); clf; hold all
        for bi = 1:numel(chrm)
            bar(bx(bi),chrm(bi),'facecolor',bclr(bi,:),'barwidth',bwh);
            errorbar(bx(bi),chrm(bi),chrel(bi),chreh(bi),'k.','linewidth',1)
        end
        plotstandard
        set(gca,'yticklabel','','xlim',[0 4],'ylim',[-.01 .12])
        set(gcf,'outerposition',[73 750-(gi-2)*200 139 220])
        
    end
end
%%
if svon
    for gi = 2:length(gtype)
        figure(fi2+max(0,gi-2)); hold all
        savname = [gtype{gi} '_ctxbyst'];
        saveas(gcf,[savpath2 savname '.tif'])
        saveas(gcf,[savpath2 savname '.fig'])
        saveas(gcf,[savpath2 savname '.eps'],'epsc')
    end
end