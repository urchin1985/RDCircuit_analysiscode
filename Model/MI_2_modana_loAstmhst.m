% scan for param sets that give suitable switching behavior for ctx
idn = 9500; XS0=[1 3];
xr1 = [-1 6]; xr2 = xr1; inc = [.2 .2];
xbn{1} = 0:.2:xr1(end);
xbn{2} = 0:.2:xr2(end);
fid = 0; dq = 0;

prm.tau = [1 1];
prm.beta = [5 4];
prm.k = [-.5 .75]; %prm.n(4)=2;
prm.n = [5 9];%[1.6 2];
prm.b = [0.2 0.25];
prm.dt = .25;
nf = 1.1;
%
fiid = 91; xcc = 0:.25:5.5;
figure(fiid);clf;hold all
rmp = [];
% high input, AIA on vs off
prm.i = .1;inp.i = [prm.i*ones(1,idn)]; 
prm.ic = .65; % AIA off
% prm.ic = 0.5; % AIA on
subplot(2,2,1); hold all; %%%% phase portrait
    title(['Input ' num2str(prm.i) ', AIA ' num2str(prm.ic)])
[nco,uo] = nullcfun_mif(xr1,xr2,inc,prm,fid,dq);
caxis([0 5])
prx = nco.nx; pry = nco.ny;
ylabel('Roaming strength'); xlabel('Dwelling strength')

%%%% simulation to obtain state probabilities
XS = runmmod_nsf(XS0,prm,inp,nf);
XS1 = XS(200:end,:); 
figure(fiid);hold all
subplot(2,2,3); hold all;
hh = make2dhist(XS(:,1),XS(:,2),xbn);
set(gca,'xlim',[0 xr1(end)],'ylim',[0 xr2(end)])
ylabel('Roaming strength'); xlabel('Dwelling strength')
rmp(1) = sum((XS1(:,2)-XS1(:,1))>0&(XS1(:,2)>2))/size(XS1,1);

% low input, AIA on
prm.ic = 2.05; % AIA on
% prm.ic = 0.5; % AIA on
subplot(2,2,2); hold all; %%%% phase portrait
    title(['Input ' num2str(prm.i) ', AIA ' num2str(prm.ic)])
[nco,uo] = nullcfun_mif(xr1,xr2,inc,prm,fid,dq);
caxis([0 5])
plot(nco.x,pry,'k:','linewidth',1.5);
plot(prx,nco.y,'r:','linewidth',1.5)
ylabel('Roaming strength'); xlabel('Dwelling strength')

%%%% simulation to obtain state probabilities
XS = runmmod_nsf(XS0,prm,inp,nf);
XS2 = XS(200:end,:);  
figure(fiid);hold all
subplot(2,2,4); hold all;
hh = make2dhist(XS(:,1),XS(:,2),xbn);
set(gca,'xlim',[0 xr1(end)],'ylim',[0 xr2(end)])
ylabel('Roaming strength'); xlabel('Dwelling strength')
rmp(2) = sum((XS2(:,2)-XS2(:,1))>0&(XS2(:,2)>2))/size(XS2,1);
rmp
colormap jet
%%
setsavpath
svpath = [dbpath '\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Plots\'];
svname = 'loin_aiastm_hst';
svfig(fiid,svname,svpath)

% % cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);


