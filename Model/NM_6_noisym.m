% scan for param sets that give suitable switching behavior for ctx
idn = 6000; XS0=[0 1.1];
xr1 = [-1 8]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0; nfi = 31;
ip = .85;
ilst = (.8:.1:2);
rl = ceil(length(ilst)/2);
ng = .2;

mbi = [];
inp.i = [ip*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)
% inp.i = [.05*ones(1,idn) ihi*ones(1,idn) .05*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)

prm = mpset.pm(end);
prm.ic = 0;
prm.i = ip;
prm.a = [1.6 3.6];
prm.ki = [.4 1];
prm.ni = [4 5];
prm.b = [0 0];
prm.beta = [4 3.7];
prm.k = [4.25 3.75]; %prm.n(4)=2;
prm.n = [2 2];%[1.6 2];

aoi = prm.a(1);

% simulate dynamics
XS = runnmod_nsy(XS0,prm,inp,ng);
XS1 = XS;

figure(nfi);clf;hold all
subplot(2,5,1:4)
plot(XS)
subplot(2,5,5);hold all
[hxc,hxt] = hist(XS(:,1),25);
% hxe = hx.BinEdges;
% hxc = hx.BinCounts;
plot(hxc/sum(hxc),hxt);
[hxc,hxt] = hist(XS(:,2),25);
plot(hxc/sum(hxc),hxt);

XS = runnmod_nsy(XS0,prm,inp,0);
XS2 = XS;

figure(nfi);
subplot(2,5,6:9)
plot(XS)
subplot(2,5,10);hold all
[hxc,hxt] = hist(XS(:,1),25);
plot(hxc/sum(hxc),hxt);
[hxc,hxt] = hist(XS(:,2),25);
plot(hxc/sum(hxc),hxt);