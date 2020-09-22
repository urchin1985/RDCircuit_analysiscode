tdat = TD_on(1).vals;
tn = size(tdat);
fid = 2; fid1 = 4;fid2 = 3;
figure(fid1);clf;hold all
plot([0 1],[0 1],'k:')
plot([.35 .35],[0 1],'k:')
xlim([0 .8]);ylim([0 .8])
figure(fid2);clf;hold all
ckf = 2; 
clear tpal tpol

for ti = 1:tn
    tpre1 = nanmedian(tdat(ti,590:599),2);
    tpst(1) = nanmean(tdat(ti,620:630),2);
    tpst(2) = nanmean(tdat(ti,630:660),2);
    tpst(3) = nanmean(tdat(ti,650:680),2);
    tpst(4) = nanmean(tdat(ti,700:720),2);
    tpm = max(tpst(2:4)); tpi = min(tpst);
    tpal(ti) = tpre1; tpol(ti) = tpst(2);
    
    switch ckf
        case 1
            figure(1);hold all;plot(tpre1*ones(1,4),tpst,'-')
            plot(tpre1,tpst(1),'bo')
            plot(tpre1,tpst(2),'go')
            plot(tpre1,tpst(3),'ro')
            scatter(tpre1,tpst(4),[],'k','filled')
            [x,y] = ginput(1);
        case 2
            figure(fid1)
%             scatter(tpre1,tpol(ti),[],'r','filled')
            scatter(tpre1,tpst(1),[],'k','filled')
        case 3
            figure(fid2);
            if tpre1<.35
            subplot 121; hold all;plot([tpre1 tpst],'bo-');ylim([0 .8])
            elseif tpre1>.4
                subplot 122; hold all;plot([tpre1 tpst],'ro-');ylim([0 1.2])
            end
%             [x,y] = ginput(1);
    end
end
trt = tpol./tpal; li = tpal<.3; hi = tpal>.4;

figure(fid);clf;hold all
subplot 211;hist(trt(li),0:.25:5); xlim([0 3])
subplot 212;hist(trt(hi),0:.25:5); xlim([0 3])