function [intp] = nullcsolve(xr1,xr2,ic,prm)
if isempty(ic)
    ic = .01;
end

x1 = xr1(1):ic:xr1(2);
x2 = xr2(1):ic:xr2(2);
xo = modfun(x1,x2,prm);

nc1 = [x1(:),xo.nx2(:)];
nc2 = [xo.nx1(:),x2(:)];

nmo = findnearestneighborf(nc1,nc2);

ncn = (nmo(:,1)<.1);
np = regionprops(ncn,'PixelIdxList');
intp = [];
for ni = 1:length(np)
    cnm = nmo(np(ni).PixelIdxList,:);
    [n1m,n1it] = min(cnm(:,1));
    n1i = np(ni).PixelIdxList(n1it);
    n2i = nmo(n1i,2);
    
    if n1m<.1
        % key alg: around intercept, min absolute distance should be flanked by two points with opposite signed distance
        % test if the above conditions are met
        n1l = nc1(((n1i-1):(n1i+1)),:);
        n2l = nc2(((n2i-1):(n2i+1)),:);
        nd = n1l-n2l;
        nck = [nd(1,1)*nd(3,1) nd(1,2)*nd(3,2)];
        if nck(1)<0&&nck(2)<0
        intp = [intp;[x1(n1i) xo.nx2(n1i)]];
        end
    end
end

% m