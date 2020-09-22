vid = find(~isnan(vax));
vai = interp1(vid,vax(vid),tvec(1:(end-1)));
%%
% figure;plot(vely)
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
%% detecting blocks of low frequency power
clo = sum(abs(cfs(f<1,:)));
clo2 = sum(abs(cfs2(f2<1,:)));
figure(11);clf; hold all
subplot 211;plot(clo);hold all;plot(clo2)
subplot 212;plotyy(1:length(clo),(clo+clo2),1:length(vax),vax)

%%
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

%% clustering
idx = kmeans(abs(cfs'),3);

figure(1);clf;hold all
plotyy(1:length(velx),velx,1:length(velx),idx); 