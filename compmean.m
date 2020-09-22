function [pout,pfdr,dmn,dci] = compmean(dset,refi,fid,clrs)
pout = nan(length(refi),length(dset));
bw = .6;

for di=1:length(dset)
    for ri = 1:length(refi)
        curf = refi(ri);
        if di~=curf
            [p,h]=ranksum(dset{di},dset{curf});
            pout(ri,di) = p;
        end
    end
end

[pfdr] = mafdr(pout(~isnan(pout)),'BHFDR',true);

[dmn,dci] = calcelmean(dset);

if fid>0
    figure(fid); clf; hold all
    
    for pi = 1:length(dset)
        if length(clrs)<1
            bar(pi,dmn(pi),bw,'color',[.3 .6 .8])
        elseif length(clrs)==1
            bar(pi,dmn(pi),bw,'facecolor',clrs{1})
        else
            bar(pi,dmn(pi),bw,'facecolor',clrs{pi})
        end
    end
    
        errorbar(1:pi,dmn,dmn-dci(1,:),dci(2,:)-dmn,'k.','linewidth',1)
    plotstandard
    xlim([.2 pi+.8])
end