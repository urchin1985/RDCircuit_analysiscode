% scan for param sets that give suitable switching behavior for ctx
idn = 3500; XS0=[0 4];
xr1 = [-1 6]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0;

prm.tau = 1*[1 1];
prm.beta = [5 4];
prm.k = [-.5 .75]; %prm.n(4)=2;
prm.n = [5 9];%[1.6 2];
prm.b = [0.2 0.25];
prm.dt = .25;
nf = .6;
%
fiid = 119; xcc = 0:.25:5.5;
figure(fiid);clf;hold all

% high input, AIA on vs off
prm.i = 1.25;inp.i = [prm.i*ones(1,idn)]; 
prm.ic = 0; % AIA off
% prm.ic = 0.5; % AIA on
subplot(3,2,2); hold all; %%%% phase portrait
title('High input, AIA OFF')
[nco,uo] = nullcfun_mif(xr1,xr2,inc,prm,fid,dq);
caxis([0 5])
prx = nco.nx; pry = nco.ny;
ylabel('Roaming strength'); xlabel('Dwelling strength')

%%%% simulation to obtain state probabilities
XS = runmmod_nsf(XS0,prm,inp,nf);
XS1 = XS; figure(115);hold all;subplot 412;cla;plot(XS)
[hxc,hxt] = hist(XS(:,2),xcc);
figure(fiid);hold all
subplot(3,2,4); hold all;
bar(hxt,hxc/sum(hxc));
xlim([0 6]); ylim([0 .45])
xlabel('Roamng strength');ylabel('Probability')

[hxc,hxt] = hist(XS(:,1),xcc);
figure(fiid);hold all
subplot(3,2,6); hold all;
bar(hxt,hxc/sum(hxc));
xlim([0 6]); ylim([0 .45])
xlabel('Dwelling strength');ylabel('Probability')

% low input, AIA on
prm.ic = 2.5; % AIA on
% prm.ic = 0.5; % AIA on
subplot(3,2,1); hold all; %%%% phase portrait
title('High input, AIA ON')
[nco,uo] = nullcfun_mif(xr1,xr2,inc,prm,fid,dq);
caxis([0 5])
plot(nco.x,pry,'k:','linewidth',1.5);
plot(prx,nco.y,'r:','linewidth',1.5)
ylabel('Roaming strength'); xlabel('Dwelling strength')

%%%% simulation to obtain state probabilities
XS = runmmod_nsf(XS0,prm,inp,nf);
XS2 = XS; figure(115);hold all;subplot 411;cla;plot(XS)
[hxc,hxt] = hist(XS(:,2),xcc);
figure(fiid);hold all
subplot(3,2,3); hold all;
bar(hxt,hxc/sum(hxc));
xlim([0 6]); ylim([0 .45])
xlabel('Roamng strength');ylabel('Probability')

[hxc,hxt] = hist(XS(:,1),xcc);
figure(fiid);hold all
subplot(3,2,5); hold all;
bar(hxt,hxc/sum(hxc));
xlim([0 6]); ylim([0 .45])
xlabel('Dwelling strength');ylabel('Probability')

colormap jet
%%
setsavpath
svpath = [dbpath '\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Plots\'];
svname = 'hiin_aiaonoff';
svfig(fiid,svname,svpath)

% % cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);


