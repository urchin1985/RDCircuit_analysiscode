gi = 1;
load([bpath gtype{gi} '_fuldata.mat']);
%% figure(105);clf;hold all
pln = 3;
for ti = 1:size(xgt.trxb,1)
    if sum(~isnan(xgt.trxb(ti,:)))>0
        spd = xgt.sp2bdb(ti,:);
        cid = find(~isnan(spd)); spd = smooth(spd(cid),60);
        ctx = smooth(xgt.chxb(ti,cid),60);
    figure(100);clf;hold all
    yyaxis left
    plot(1:length(spd),spd)
    yyaxis right
    plot(1:length(spd),ctx)
    [x,y] = ginput(1);
    end
end

%%
ti = 48;
xp = xgt.trxb(ti,cid); yp = xgt.tryb(ti,cid);
cp = spd';

figure(101)
colorline_fun(xp,yp,cp,20); caxis([0 .15])
