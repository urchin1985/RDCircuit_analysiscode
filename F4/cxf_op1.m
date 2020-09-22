xed = -10:10;
figure(120);clf;hold all
subplot 221; 
scatter(wc1(:,1),wc1(:,2))
xlim([0 2000]);ylim([-2000 2000])
subplot 222; 
scatter(wc2(:,1),wc2(:,2))
xlim([0 2000]);ylim([-2000 2000])
subplot 223;
cdd = abs(wc1(:,2))>100;
histogram(wc1(cdd,2)./wc1(cdd,1),xed)
subplot 224;
% cdd = cxst2(:,2)<-100;
cdd = abs(wc1(:,2))>100;
histogram(wc2(cdd,2)./wc2(cdd,1),xed)

figure(121);clf;hold all
subplot 221; 
scatter(tc1(:,1),tc1(:,2))
xlim([0 2000]);ylim([-2000 2000])
subplot 222; 
scatter(tc2(:,1),tc2(:,2))
xlim([0 2000]);ylim([-2000 2000])
subplot 223;
cdd = abs(tc1(:,2))>100;
histogram(tc1(cdd,2)./tc1(cdd,1),xed)
subplot 224;
% cdd = cxst2(:,2)<-100;
cdd = abs(tc1(:,2))>100;
histogram(tc2(cdd,2)./tc2(cdd,1),xed)