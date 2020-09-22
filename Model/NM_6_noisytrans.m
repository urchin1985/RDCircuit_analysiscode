% scan for param sets that give suitable switching behavior for ctx
idn = 500; XS0=[1 7];
xr1 = [-1 8]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0; nfi = 31;
rl = ceil(length(ilst)/2);
ng = .1; ip = .85;
mbi = [];

prm = mpset.pm(end);
prm.i = ip;
prm.a = [1.6 3.6];
prm.ki = [.4 1];
prm.ni = [4 5];
prm.b = [0 0];
prm.beta = [4 3.7];
prm.k = [4.25 3.75]; %prm.n(4)=2;
prm.n = [2 2];%[1.6 2];

inp.i = [ip*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)


figure(13);clf;hold all
subplot(4,1,1:3)
    [nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);
    caxis([0 .75])
    hold all
    
    x00 = [1 7];%[1 7;-.5 3;5 8;3 7.5;1 7;0 0;7 7];
    for pi = 1:size(x00,1)
        XS0 = x00(pi,:);
        XS = runnmod_nsy(XS0,prm,inp,0.05);
    plot(XS(1:10:end,1),XS(1:10:end,2),'k.-','markersize',10)
    end
    
    cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% cmap = cmap(end:-1:1,:);
colormap(cmap)
set(gca,'xtick',0:3:9,'ytick',0:3:9)

subplot 414; hold all
plot([0 idn],3.5*ones(1,2),'k:')
plot(XS)