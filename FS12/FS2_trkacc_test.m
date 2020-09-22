xsp = OP.stagevel(:,1); ysp = OP.stagevel(:,2);
wx = OP.wormpos(:,1); wy = OP.wormpos(:,2);
wc = [median(wx) median(wy)];

spf = sqrt(xsp.^2+ysp.^2);
wd = [wx-wc(:,1) wy-wc(:,2)];
wdn = sqrt(wd(:,1).^2+wd(:,2).^2);

figure(2);clf;hold all
yyaxis left; plot(spf); ylim([0 2500])
yyaxis right; plot(wdn); ylim([0 20])

figure(3);clf;hold all
make2ddhist(spf,wdn,0:100:2500,0:20,2)

figure(4);clf;hold all
make2dschist({spf},{wdn},[0 0 1],[200 1])
xlim([0 2500]);ylim([0 20])