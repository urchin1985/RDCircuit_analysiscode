wc = [wc1;wc2]; tc = [tc1;tc2];

figure(99);clf;hold all
cdd = wc(:,2)<-50;
wrp = wc(cdd,2)./wc(cdd,1);
subplot 221;histogram(wrp,-10:0)
cdd = wc(:,2)>50;
wrn = wc(cdd,2)./wc(cdd,1);
subplot 222;histogram(wrn,0:10)

cdd = tc(:,2)<-50;
trp = tc(cdd,2)./tc(cdd,1);
subplot 223;histogram(tc(cdd,2)./tc(cdd,1),-10:0)
cdd = tc(:,2)>50;
trn = tc(cdd,2)./tc(cdd,1);
subplot 224;histogram(tc(cdd,2)./tc(cdd,1),0:10)

[median(wrp)/median(wrn);median(trp)/median(trn)]