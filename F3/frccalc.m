function frcs = frccalc(ddat,rdat,dn,th,rn)
dln = length(ddat); rln = length(rdat);
frcs = struct('dwi',[],'rmd',[]);

% calc percent increase

for ri = 1:rn
    if dn<.9*dln
        dix = randperm(dln,min(dn,dln));
    else
        dix = randsample(dln,min(dn,dln),true);
    end
    ddt = ddat(dix);
    dwinc = find(ddt>th); frcs.dwi(ri) = length(dwinc)/length(ddt);
    
    if dn<.9*rln
        rix = randperm(rln,min(dn,rln));
    else
        rix = randsample(rln,min(dn,rln),true);
    end
    rdt = rdat(rix);
    rmdc = find(rdt<-th); frcs.rmd(ri) = length(rmdc)/length(rdt);
end

% calc bootstrap mean and ci
frcs.dwim = nanmean(frcs.dwi); frcs.rmdm = nanmean(frcs.rmd);
frcs.dwci = prctile(frcs.dwi,[2.5 97.5]);
frcs.rmci = prctile(frcs.rmd,[2.5 97.5]);
