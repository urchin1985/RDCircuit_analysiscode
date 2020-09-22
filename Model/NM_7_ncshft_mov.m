% scan for param sets that give suitable switching behavior for ctx
idn = 500; XS0=[1 7];
xr1 = [-1 8]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0; nfi = 31;
rl = ceil(length(ilst)/2);
ng = .1; ip = .657;

mbi = [];
% inp.i = [ip*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)
inp.i = [ip*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)

prm = mpset.pm(end);
% prm.fc = 0.001;
% prm.k = [3.5 2.75]; %prm.n(4)=2;
% prm.n = [1.6 2];
% prm.a = [2.2 3];
% prm.ki = [.8 1];
% prm.ni = [2 5];
% prm.b = [0 0];
% prm.beta = [4 3.7];
prm.i = ip;
prm.a = [1.6 3.6];
prm.ki = [.4 1];
prm.ni = [4 5];
prm.b = [0 0];
prm.beta = [4 3.7];
prm.k = [4.25 3.75]; %prm.n(4)=2;
prm.n = [2 2];%[1.6 2];
prm1 = prm;     prm1.ic = 0;


ilst = (0.15:.025:1.9);
klst = [.725 1]; % .9 1.4
fm = 1;
clear M
myVid = VideoWriter('ncshft.avi');
myVid.FrameRate=3;
open(myVid);

for pi = 1:length(ilst)
    figure(18);clf;hold all
    clear tp1 tp2 xp11 xp12 xp21 xp22
    prm.i = ilst(pi); prm1.i = prm.i;
    subplot(1,2,1)
    [nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);
    % % % surf(Z)
    caxis([0 .75]);
    set(gca,'xticklabel','','yticklabel','')
    axis tight manual
    set(gca,'nextplot','replacechildren');
    title(['I(t) = ' num2str(prm.i)])
    hold all
    if pi == 1
        nci1 = nco;
    else
        plot(nco.x,nci1.ny,'g--','linewidth',2)
        plot(nci1.nx,nco.y,'r--','linewidth',2)
    end
    
    hold all
    subplot(1,2,2)
    [nco,uo] = nullcfun_nm(xr1,xr2,inc,prm1,fid,dq);
    caxis([0 .75])
    cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
    % cmap = cmap(end:-1:1,:);
    colormap(cmap)
    set(gca,'xticklabel','','yticklabel','')
    title(['I(t) = ' num2str(prm.i)])
    hold all
    if pi == 1
        nci2 = nco;
    else
        plot(nco.x,nci2.ny,'g--','linewidth',2)
        plot(nci2.nx,nco.y,'r--','linewidth',2)
    end
    
    frm = getframe(gcf);
    writeVideo(myVid,frm)
    fm = fm+1;
    if sum(abs(prm.i-klst)<.01)%sum(ismember(prm.i,klst))
        for ii = 1:8
            frm = getframe(gcf);
            writeVideo(myVid,frm)
            fm = fm+1;
        end
    end
end

close(myVid)
%%
savpath = 'C:\Users\Ni Ji\Dropbox (MIT)\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Animations\';
cd(savpath)

