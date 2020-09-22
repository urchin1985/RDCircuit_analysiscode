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

aoi = prm.a(1);

figure(18);clf;hold all
subplot(5,2,[1:2:7])
[nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);
caxis([0 .75]);
set(gca,'xticklabel','','yticklabel','')
hold all
subplot(5,2,[2:2:8])
prm1 = prm;
prm1.ic = 0;
[nco,uo] = nullcfun_nm(xr1,xr2,inc,prm1,fid,dq);
caxis([0 .75])
cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% cmap = cmap(end:-1:1,:);
colormap(cmap)
set(gca,'xticklabel','','yticklabel','')
hold all

clear M tp1 tp2 xp11 xp12 xp21 xp22
x00 = [1 7;-.5 3;5 8;3 7.5;1 7;0 0;-1 5;4 7];
fm = 1;
for pi = 1:length(x00)
    XS0 = x00(pi,:);
    for xi = 1:floor(length(XS1)/10)
        subplot(5,2,[1:2:7])
        XS1 = runnmod_nsy(XS0,prm,inp,0);
        XS2 = runnmod_nsy(XS0,prm1,inp,0);
        if ~exist('tp1','var')
            tp1 = plot(XS1(1:10:(10*xi),1),XS1(1:10:(10*xi),2),'ko-','markersize',5,'markerfacecolor',.7*ones(1,3));
        else
            set(tp1,'XData',XS1(1:10:(10*xi),1),'YData',XS1(1:10:(10*xi),2))
        end
        subplot(5,2,9); hold all;xlim([0 40]); ylim([0 6])
        if ~exist('xp11','var')
            xp11 = plot(XS1(1:10:(10*xi),1),'k.-','markersize',15);
        else
            if xi==1
                set(xp11,'YData',XS1(1:(10*xi),1))
            elseif norm(XS1(10*xi,:)-XS1(10*(xi-1),:))>.05
                set(xp11,'YData',XS1(1:10:(10*xi),1))
            end
        end
        if ~exist('xp12','var')
            xp12 = plot(XS1(1:10:(10*xi),2),'.-','markersize',15,'markeredgecolor',.6*ones(1,3));
        else
            if xi==1
                set(xp12,'YData',XS1(1:10:(10*xi),2))
            elseif norm(XS1(10*xi,:)-XS1(10*(xi-1),:))>.05
                set(xp12,'YData',XS1(1:10:(10*xi),2))
            end
        end
        
        subplot(5,2,[2:2:8]); hold all;
        if ~exist('tp2','var')
            tp2 = plot(XS2(1:10:(10*xi),1),XS2(1:10:(10*xi),2),'ko-','markersize',5,'markerfacecolor',.7*ones(1,3));
        else
            set(tp2,'XData',XS2(1:10:(10*xi),1),'YData',XS2(1:10:(10*xi),2))
        end
        
        subplot(5,2,10); hold all;xlim([0 40]); ylim([0 6])
        if ~exist('xp21','var')
            xp21 = plot(XS2(1:10:(10*xi),1),'k.-','markersize',15);
        else
            if xi==1
                set(xp21,'YData',XS2(1:10:(10*xi),1))
            elseif norm(XS2(10*xi,:)-XS2(10*(xi-1),:))>.05
                set(xp21,'YData',XS2(1:10:(10*xi),1))
            end
        end
        if ~exist('xp22','var')
            xp22 = plot(XS2(1:(10*xi),2),'.-','markersize',15,'markeredgecolor',.6*ones(1,3));
        else
            if xi==1
                set(xp22,'YData',XS2(1:10:(10*xi),2))
            elseif norm(XS2(10*xi,:)-XS2(10*(xi-1),:))>.05
                set(xp22,'YData',XS2(1:10:(10*xi),2))
            end
        end
        
        
        M(fm) = getframe(gcf);
        fm = fm+1;
    end
    
end


%%
savpath = 'C:\Users\Ni Ji\Dropbox (MIT)\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Animations\';
cd(savpath)
myVid = VideoWriter('nullctraj.avi');
% myVid.FrameRate=3;
open(myVid);
writeVideo(myVid,M);
close(myVid)
