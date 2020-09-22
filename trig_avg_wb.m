
for di = 1:length(P_on)
    for ri1 = 1:rl1
        curn1 = prn(ri1):(prn(ri1+1)-1);
        mdat = P_on(di).vals(tbi,curn1);
        predat(ti,ri1,di) = nanmean(mdat);
        if sum(~isnan(mdat))
            bci = bootci(100,@nanmean,mdat);
            prebl(ti,ri1,di) = bci(1);
            prebh(ti,ri1,di) = bci(2);
        end
    end
    
    for ri2 = 1:rl2
        curn2 = pon(ri2):(pon(ri2+1)-1);
        mdat = P_on(di).vals(tbi,curn2);
        posdat(ti,ri2,di) = nanmean(mdat);
        if sum(~isnan(mdat))
            bci = bootci(100,@nanmean,mdat);
            posbl(ti,ri1,di) = bci(1);
            posbh(ti,ri1,di) = bci(2);
        end
    end
end

for ri1 = 1:rl1
    curn1 = prn(ri1):(prn(ri1+1)-1);
    tdat = T_on(coi).vals(tbi,curn1);
    preca(ti,ri1) = nanmean(tdat);
end

for ri2 = 1:rl2
    curn2 = pon(ri2):(pon(ri2+1)-1);
    tdat = T_on(coi).vals(tbi,curn2);
    posca(ti,ri2) = nanmean(tdat);
end