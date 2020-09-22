% scan for param sets that give suitable switching behavior for ctx
idn = 6500; XS0=[0 5];
xr1 = [-1 6]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0;

prm.tau = 2*[1 1];
prm.beta = [5 4];
prm.k = [-.5 .75]; %prm.n(4)=2;
prm.n = [5 9];%[1.6 2];
prm.b = [0.2 0.25];
prm.dt = .25;
nf = 1.2;
prm.i = .5;
inp.i = prm.i*ones(1,idn);

%
fiid = 128; 

figure(fiid);clf;hold all

% low input, AIA on
prm.ic = 0; % AIA on
% prm.ic = 0.5; % AIA on
subplot(2,2,1); hold all; %%%% phase portrait
title(['Input ' num2str(prm.i) ', AIA ' num2str(prm.ic)])
[nco,uo] = nullcfun_mif(xr1,xr2,inc,prm,fid,dq);
caxis([0 5])
ylabel('Roaming strength'); xlabel('Dwelling strength')

%%%% simulation to obtain state probabilities
XS = runmmod_nsf(XS0,prm,inp,nf);
XS2 = XS; figure(115);hold all;subplot 211;cla;plot(XS)

figure(fiid);hold all
subplot(2,2,3); hold all;
make2dhist(XS(:,1),XS(:,2),30)

% low input, AIA on
prm.ic = 2; % AIA on
% prm.ic = 0.5; % AIA on
subplot(2,2,2); hold all; %%%% phase portrait
title(['Input ' num2str(prm.i) ', AIA ' num2str(prm.ic)])
[nco,uo] = nullcfun_mif(xr1,xr2,inc,prm,fid,dq);
caxis([0 5])
ylabel('Roaming strength'); xlabel('Dwelling strength')

%%%% simulation to obtain state probabilities
XS = runmmod_nsf(XS0,prm,inp,nf);
XS2 = XS; figure(115);hold all;subplot 212;cla;plot(XS)

figure(fiid);hold all
subplot(2,2,4); hold all;
make2dhist(XS(:,1),XS(:,2),30)


colormap jet
%%
setsavpath
svpath = [dbpath '\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Plots\'];
svname = 'mod_dyntest1';
svfig(fiid,svname,svpath)

% % cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% % % cmap = cmap(end:-1:1,:);
% % colormap(cmap)


