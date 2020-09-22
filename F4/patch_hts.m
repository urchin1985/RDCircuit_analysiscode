pbool = 0;
tini = 20;
fmin = tini*180+1;
if ~exist('dth','var')
    dth = 500;
end

distmat_b

dff = [dtx;xgt.d2b;xgt.d2a];
%
dts = [5 30 60 90]; 
dfd = cell(1,lenth(dts));
for di = 1:length(dts)
dfd{di} = dff(:,dts(di)*180);
end

dx = 50;
xc = -1500:dx:1500;
xlm = [xc(1) xc(end)];

plt = [15 50 85];
[prctile(dfd{1},plt);prctile(dfd{2},plt);prctile(dfd{3},plt)]


kshistgen(dat,xc,dx,bcl,ecl,kcl,aph,dp)