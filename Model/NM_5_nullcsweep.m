% scan for param sets that give suitable switching behavior for ctx
idn = 350; XS0=[0 1.1];
xr1 = [-1 8]; xr2 = [0 9]; inc = [.2 .2];
fid = 0; dq = 0; nfi = 30;
ihi = 1.8; iml = 1.1; imi = .53;
ilst = (0.15:.2:2.2);
rl = ceil(length(ilst)/2);

mbi = [];
inp.i = [ihi*ones(1,idn) imi*ones(1,idn) ihi*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)
% inp.i = [.05*ones(1,idn) ihi*ones(1,idn) .05*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)
load('NMparset_21420.mat')

prm = mpset.pm(end);
prm.ic = 1;
prm.a = [1.6 3.6];
prm.ki = [.4 1];
prm.ni = [4 5];
prm.b = [0 0];
prm.beta = [4 3.7];
prm.k = [4.25 3.75]; %prm.n(4)=2;
prm.n = [2 2];%[1.6 2];

aoi = prm.a(1);

figure(17-round(prm.ic));clf;hold all

for ii = 1:length(ilst)
    subplot(2,rl,ii); hold all;
    prm.i = ilst(ii);
    title(num2str(prm.i))
    [nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);
    caxis([0 .75])
    if ii>1
        plot(nco.x,pry,'g:','linewidth',1.5); 
        plot(prx,nco.y,'r:','linewidth',1.5)
    end
    if ii==1
    prx = nco.nx; pry = nco.ny;
    end
    prx(27)
end

cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% cmap = cmap(end:-1:1,:);
colormap(cmap)

inpfun_plot
%%
%%%%% now reduce sensory coupling to x1 %%%%%%%
% prm.fc = .001;
% 
% inpfun_plot
