% reconstruct dis2bord matrix
d2bmat = nansum(cat(3,xgt.d2b,(-xgt.d2a)),3);
d2bmat(d2bmat==0) = nan;
% d2bmat = nan(size(xgt.d2b));
xt = 0;
for ti = 1:size(d2bmat,1)
    if sum(~isnan(xgt.trxb(ti,:))) % if crossing track
    bfm = xgt.xfrm(ti,:); bid = find(~isnan(bfm));   bfm = bfm(~isnan(bfm)); 
    d2b = xgt.d2bdb(ti,:);
        d2bmat(ti,bfm) = d2b(bid);
        xt = xt+1;
    end
end
xin = nansum(xgt.trx(:,1:30));
xl = sum(xin>0);

xprt(gi) = xt/xl
sptb(gi) = nansum(xgt.sp2bdb(:))/xt;
% d2bm = nanmean(d2bmat,1);figure(11+gi-1);clf;plot(d2bm)
% figure(22+gi-1);clf;imagesc(d2bmat)