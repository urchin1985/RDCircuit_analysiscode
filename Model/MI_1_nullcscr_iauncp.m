% scan for param sets that give suitable switching behavior for ctx
idn = 350; XS0=[0 1.1];
xr1 = [-1 8]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0;

prm.tau = [1 1];
prm.beta = [5 4];
prm.k = [-.5 .75]; %prm.n(4)=2;
prm.n = [5 9];%[1.6 2];
prm.b = [0.2 0.25];
ilst = 0:.25:1.25;%0:.2:3;
il = (length(ilst));
rl = ceil(length(ilst)/2);
icc = 0:1:4; % 0:.5:2;% 
icl = length(icc);

fiid = 21;
figure(fiid);clf;hold all

for ii = 1:il
    prm.i = ilst(ii);
    for ici = 1:icl
        subplot(icl,il,(ici-1)*il+ii); hold all;
        
        prm.ic = icc(ici);
        [nco,uo] = nullcfun_sc(xr1,xr2,inc,prm,fid,dq);
        caxis([0 5])
        if ii>1||ici>1
            plot(nco.x,pry,'k:','linewidth',1.5);
            plot(prx,nco.y,'r:','linewidth',1.5)
        end
        if ii==1&&ici==1
            prx = nco.nx; pry = nco.ny;
        end
        
        if ii==1
           ylabel(['AIA ' num2str(prm.ic)]) 
        end
        
        if ici<icl
            set(gca,'xticklabel','')
        end
        if ii>1
           set(gca,'yticklabel','') 
        end
        if ici==1
           title(['Ri ' num2str(prm.i)]) 
        end
    end
end



cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% cmap = cmap(end:-1:1,:);
colormap(cmap)

%%
setsavpath
svpath = [dbpath '\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Plots\'];
svname = 'mod_prmsc_iaucp_fine';
svfig(fiid,svname,svpath)

