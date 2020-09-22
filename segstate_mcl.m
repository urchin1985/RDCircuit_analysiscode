
vdata = vaxintp;
vdata = medfilt1(vdata/prctile(vdata,99),5);
vbin = medfilt1(double(vdata>=-.05),7);

xin = 1:length(vdata);
yin = vdata/prctile(vdata,99);
vmed = slidingmedian(xin,yin,55,0);
vvar = slidingvar(xin,yin,55,0);
lvar = log(abs(vvar));

% interpolate to make vmed same length as velx
vmf = interp1(catime,vmed,tvec(pid)-tvec(1));

figure(7);clf;hold all
plot(tvec(1:end-1)-tvec(1),vax/2000,'linewidth',1.5);
plot(catime,vmed,'linewidth',1.5)
figure(18);clf;hold all
histogram2((vmed),lvar,-1:.03:1,-9:.3:.3,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
%%
[cfs,f] = cwt(vely,100,'amor');
figure
contour(time,f,abs(cfs))
grid on
c = colorbar;
xlabel('Milliseconds')
ylabel('Frequency')
c.Label.String = 'Magnitude';

% figure;plot(velx)
[cfs2,f2] = cwt(velx,100,'amor');
figure
contour(time,f2,abs(cfs2))
grid on
c = colorbar;
xlabel('Milliseconds')
ylabel('Frequency')
c.Label.String = 'Magnitude';

% detecting blocks of low frequency power
clo = sum(abs(cfs(f<1,:)));
clo2 = sum(abs(cfs2(f2<1,:)));
figure(11);clf; hold all
subplot 211;plot(clo);hold all;plot(clo2)
subplot 212;plotyy(1:length(clo),(clo+clo2),1:length(vax),vax)

% detecting blocks of high frequency power
chi = sum(abs(cfs(f>1&f<=2,:)));
chi2 = sum(abs(cfs2(f2>1&f2<=2,:)));
figure(1);clf; hold all
subplot 211;plot(chi);hold all;plot(chi2)
subplot 212;plotyy(1:length(chi),(chi+chi2),1:length(vax),vax)
%%
figure(12);clf; hold all
histogram2((clo+clo2),(chi+chi2),'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
figure(13);clf; hold all
histogram2(abs(pltval),(chi+chi2),'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
figure(14);clf; hold all
histogram2((clo+clo2),abs(pltval),'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')

figure(6);clf; hold all
histogram2(abs(vmf),(clo+clo2),'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')

%%
[amt,amf] = tilingmedian(time,abs(anvel),10);
figure(10);clf;hold all
subplot 211; hold all; plot(tvec(2:end),vax)
plot(amt,(amf)*15,'linewidth',1.5)
plot(tvec([2 end]),[0 0],'k-')
xlim(tvec([2 end]))

subplot 212; hold all
plot(time,abs(anvel))
plot(amt,amf,'g','linewidth',1.5)
xlim(tvec([2 end]))