% specify circuit params
% clear
nmparams5620
xr1 = [-1 10]; xr2 = xr1; inc = [.2 .2];
nf = .25;

prm.b = [3 .5];%[-1.75 1.2];
idn = 1200; ip0 = .2; icf = 1;
fid = 0; dq = 0; nl = .25;
inp.i = [ip0*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)
% prm.beta = [3.4 3.7]; prm.b = [0 0];
% prm.k = [3.25 2.5]; %prm.n(4)=2;
% prm.n = [2 3];%[1.6 2];
prm.tau = 5*[1 1];
prm1 = prm; prm1.ic = 0; prm.ic = 2;
XS0=[6 0]; 

XS1 = runnmod_nsy_icf(XS0,prm,icf,inp,nl);
XS2 = runnmod_nsy_icf(XS0,prm1,icf,inp,nl);

prm.i = ip0; prm1.i = prm.i;

figure(18); clf; hold all
subplot(2,2,1);cla; title(num2str(prm.i))
[nco,uo] = nullcfun_nm_icf(xr1,xr2,inc,prm,icf,fid,dq);
caxis([0 .75]); hold all
% plot(XS1(:,1),XS1(:,2),'k.-','markerfacecolor','r','markersize',6) 
subplot 222; cla
plot(XS1,'-','linewidth',1)

subplot 223;cla;
[nco,uo] = nullcfun_nm_icf(xr1,xr2,inc,prm1,icf,fid,dq);
caxis([0 .75]); hold all
% plot(XS2(:,1),XS2(:,2),'k.-','markerfacecolor','r','markersize',6) 
subplot 224; cla
plot(XS2,'-','linewidth',1)