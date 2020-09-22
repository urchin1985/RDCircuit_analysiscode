% scan for param sets that give suitable switching behavior for ctx
idn = 350; XS0=[0 1.1];
xr1 = [-1 8]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0; 

prm.tau = [1 1];
prm.beta = [5 4];
prm.k = [-.5 .75]; %prm.n(4)=2;
prm.n = [5 9];%[1.6 2];
prm.b = [0.2 0.25];
ilst = 0:.25:1.5;%0:.2:3;
il = (length(ilst));
rl = ceil(length(ilst)/2);

fiid = 20;
figure(fiid);clf;hold all

for ii = 1:length(ilst)
    subplot(2,il,ii); hold all;
    prm.i = ilst(ii);
    prm.ic = 1.35*prm.i;
    title(num2str(prm.i))
    [nco,uo] = nullcfun_sc(xr1,xr2,inc,prm,fid,dq);
        caxis([0 5])
    if ii>1
        plot(nco.x,pry,'k:','linewidth',1.5); 
        plot(prx,nco.y,'r:','linewidth',1.5)
    end
    if ii==1
    prx = nco.nx; pry = nco.ny;
    end
    
    prm.ic = 0;
    subplot(2,il,ii+il); hold all;
    prm.i = ilst(ii);
    title(num2str(prm.i))
    [nco,uo] = nullcfun_sc(xr1,xr2,inc,prm,fid,dq);
    caxis([0 5])
end

subplot(2,il,1); ylabel('AIA ON')
subplot(2,il,il+1); ylabel('AIA OFF')

cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% cmap = cmap(end:-1:1,:);
colormap(cmap)

%%
setsavpath
svpath = [dbpath '\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Plots\'];
svname = 'mod_prmsc_iacp';
svfig(fiid,svname,svpath)

