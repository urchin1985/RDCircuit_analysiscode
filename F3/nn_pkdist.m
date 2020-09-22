[~,ahi] = max(gmfit.mu(:,1));
[~,nhi] = max(nsm_gmfit(:,1));

andful = [];
for fi = unique(Fdx')
    di = find(Fdx == fi);
    cdat1 = Cdat(di,1);
    cdat3 = Cdat(di,3);
    ncl = clxn(di);
    acl = clxa(di);
    
    ahp = acl==ahi;
    ap = regionprops(ahp,'Area','PixelIdxList');
    apdur = cat(1,ap.Area);
    clear apon apmid
    for ai = 1:length(ap)
        apon(ai) = ap(ai).PixelIdxList(1);
        apmid(ai) = apon(ai)+round(apdur(ai)/2);
    end
    asta = [apon;apdur';apmid];
    % filter for duration >100 bouts and record start time
    ki = apdur>100;
    asta = asta(:,ki);
    
    % gather NSM peak start times
    nhp = ncl==nhi;
    np = regionprops(nhp,'Area','PixelIdxList');
    npdur = cat(1,np.Area);
    clear npon
    for ai = 1:length(np)
        npon(ai) = np(ai).PixelIdxList(1);
    end
    nsta = [npon;npdur'];
    
    % now find nearest neighbor
    clear nmatc
    anpr1 = findnearestneighbor(asta(1,:),nsta(1,:));
    nmatc = abs(nsta(1,anpr1)-asta(1,:));
    anpr2 = findnearestneighbor(asta(3,:),nsta(1,:));
    nmatc = [nmatc;abs(nsta(1,anpr2)-asta(3,:))];
    andist = min(nmatc,[],1);
    andful = [andful andist];
end

[xn,xc] = hist(andful,0:20:300);
plot(xc,xn/sum(xn))
xlim([-50 580])