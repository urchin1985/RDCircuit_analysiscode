% extract vmed, vvar, wlet spectra from population RD tracks
ftrk = finalTracks;
ti = 1;

ftm = ftrk(ti).Time; fsp = ftrk(ti).Speed; ftn = 0:.5:ftm(end);
fap = ftrk(ti).AngSpeed;
sintp = interp1(ftm,fsp,ftn); spsm = smooth(sintp,13);

xin = 1:length(spsm);
yin = spsm/prctile(spsm,99);
vmed = slidingmedian(xin,yin,55,0);
vvar = slidingvar(xin,yin,55,0);
lvar = log(abs(vvar));

plot2dhist(vmed,vvar,[],[],5)

vmf = interp1(ftn,vmed,ftm);
plot2dhist(vmf,abs(fap),[],[],6)

%%
[tt,vmt] = tilingmedian(ftm,fsp,30);
[tt,amt] = tilingmedian(ftm,abs(fap),30);
figure(21);clf;hold all
subplot 211; hold all;
plot(ftm,fsp); 
plot(ftn,vmed*prctile(spsm,99),'linewidth',1.5)
plot(tt,vmt)
plot(ftm,.1*NewSeq(ti).states,'g','linewidth',1.5)
subplot 212; hold all;
plot(ftm,abs(fap)); plot(tt,amt,'linewidth',1.5)
plot(ftm,100*NewSeq(ti).states,'g','linewidth',1.5)

plot2dhist(vmt,amt,[],[],6)
%%
figure(20);clf;hold all
s(1)= subplot(311); hold all
plot(ftm,fsp); %plot(ftn,spsm)
xlim([ftm(1) ftm(end)])
s(2) = subplot(312); hold all
plot(ftn,vmed*prctile(spsm,99))
hold all; plot(ftm,.05*NewSeq(ti).states,'g','linewidth',1.5)
hold all; plot(ftm,.025*States(ti).states,'r','linewidth',1.5)

xlim([ftm(1) ftm(end)])
s(3)= subplot(313); hold all
%plot(ftm,fap)
stem(ftm,fap)
xlim([ftm(1) ftm(end)])
linkaxes(s,'x')

plot(ftm,100*States(ti).states,'linewidth',1.5)
%% wavelet spectral analysis on angular speed
fai = ~isnan(fap); ftnew = ftm(1):.3333:ftm(end);
faitp = interp1(ftm(fai),fap(fai),ftnew);
[cfs,f] = cwt(double(faitp(4:end)),3,'amor');
figure(25)
contour(ftnew(4:end),f,abs(cfs))
grid on
c = colorbar;
xlabel('Seconds')
ylabel('Frequency')
c.Label.String = 'Magnitude';
hold all; plot(ftm,.5*NewSeq(ti).states,'g','linewidth',1.5)
anspc = sum(abs(cfs));

% wavelet spectrum analysis on speed
fsi = ~isnan(fsp); ftnew = ftm(1):.3333:ftm(end);
fsitp = interp1(ftm(fsi),fsp(fsi),ftnew);
[cfs2,f2] = cwt(double(fsitp(4:end)),3,'amor');
figure(25);clf
contour(ftnew(4:end),f2,abs(cfs2))
grid on
c = colorbar;
xlabel('Seconds')
ylabel('Frequency')
c.Label.String = 'Magnitude';
hold all; plot(ftm,.5*States(ti).states,'r','linewidth',1.5)
vspc = sum(abs(cfs2));
%%
figure(26);clf; hold all
subplot 211; plot(tt,vmt,'g','linewidth',1.5)
xlim([ftm([1 end])])
subplot 212; hold all
plotyy(ftnew(4:end),anspc,ftnew(4:end),vspc)
 plot(ftm,1700*States(ti).states,'m','linewidth',1.5)
 xlim([ftm([1 end])])
%%
[cfs,f] = cwt(vely,100,'amor');
figure
contour(time,f,abs(cfs))
grid on
c = colorbar;
xlabel('Milliseconds')
ylabel('Frequency')
c.Label.String = 'Magnitude';

%% figure;plot(velx)
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