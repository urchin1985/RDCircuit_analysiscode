% scan for param sets that give suitable switching behavior for ctx
idn = 3500; XS0=[0 1.1];
xr1 = [-1 6]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0;

prm.tau = [1 1];
prm.beta = [5 4];
prm.k = [-.5 .75]; %prm.n(4)=2;
prm.n = [5 9];%[1.6 2];
prm.b = [0.2 0.25];
nf = .2;

% low input, AIA on vs off
inp.i = [1*ones(1,idn)];
prm.ic = 0.5; % AIA on
figure(118);clf;hold all
subplot(2,3,1); hold all;
title('Low input, AIA ON')
[nco,uo] = nullcfun_mi(xr1,xr2,inc,prm,fid,dq);
caxis([0 5])
    prx = nco.nx; pry = nco.ny;

XS = runnmod_nsy(XS0,prm,inp,nf);
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

prm.ic = 0;
subplot(2,il,ii+il); hold all;
prm.i = ilst(ii);
title(num2str(prm.i))
[nco,uo] = nullcfun_mi(xr1,xr2,inc,prm,fid,dq);
caxis([0 5])



cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% cmap = cmap(end:-1:1,:);
colormap(cmap)

%%
%%%%% now reduce sensory coupling to x1 %%%%%%%
% prm.fc = .001;
%
% inpfun_plot
