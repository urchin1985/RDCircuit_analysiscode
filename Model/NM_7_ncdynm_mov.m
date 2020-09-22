% scan for param sets that give suitable switching behavior for ctx
idn = 500; XS0=[1 7];
xr1 = [-1 8]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0; nfi = 31;
rl = ceil(length(ilst)/2);
ng = .1; ip = .657;
XS = cell(1,5);

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
tp = 10;

ilst = [.7 1 2];
x00 = [-1.7 7.5;5 7.5;8 8;-1 3;-2 -1; 2 0; 7 0];

fm = 1;
clear M
myVid = VideoWriter('ncdynm.avi');
% myVid.FrameRate=3;
open(myVid);

for pi = 1:length(ilst)
    figure(19);clf;hold all
    clear tp1 tp2 tp3 tp4 tp5 tp6 tp7
    prm.i = ilst(pi);
    [nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);
    % % % surf(Z)
    caxis([0 .75]);
    set(gca,'xticklabel','','yticklabel','')
    title(['I(t) = ' num2str(prm.i)])
    axis tight manual
    set(gca,'nextplot','replacechildren');
    colormap(cmap)
    set(gca,'xticklabel','','yticklabel','')
    hold all
    
    inp.i = [prm.i*ones(1,idn)];
    for ci = 1:length(x00)
        XS0 = x00(ci,:);
        XS{ci} = runnmod_nsy(XS0,prm,inp,0);
    end
    
    for xi = 1:floor(idn/tp)
        
        if ~exist('tp1','var')
            tp1 = plot(XS{1}(1:tp:(10*xi),1),XS{1}(1:tp:(10*xi),2),'ko-','markersize',5,'markerfacecolor',.7*ones(1,3));
        else
            set(tp1,'XData',XS{1}(1:tp:(10*xi),1),'YData',XS{1}(1:tp:(10*xi),2))
        end
        
        if ~exist('tp2','var')
            tp1 = plot(XS{2}(1:10:(10*xi),1),XS{2}(1:10:(10*xi),2),'ko-','markersize',5,'markerfacecolor',.7*ones(1,3));
        else
            set(tp1,'XData',XS{2}(1:10:(10*xi),1),'YData',XS{2}(1:10:(10*xi),2))
        end
        
        if ~exist('tp3','var')
            tp1 = plot(XS{3}(1:10:(10*xi),1),XS{3}(1:10:(10*xi),2),'ko-','markersize',5,'markerfacecolor',.7*ones(1,3));
        else
            set(tp1,'XData',XS{3}(1:10:(10*xi),1),'YData',XS{3}(1:10:(10*xi),2))
        end
        
        if ~exist('tp4','var')
            tp1 = plot(XS{4}(1:10:(10*xi),1),XS{4}(1:10:(10*xi),2),'ko-','markersize',2,'markerfacecolor',.7*ones(1,3));
        else
            set(tp1,'XData',XS{4}(1:10:(10*xi),1),'YData',XS{4}(1:10:(10*xi),2))
        end
        
        if ~exist('tp5','var')
            tp1 = plot(XS{5}(1:10:(10*xi),1),XS{5}(1:10:(10*xi),2),'ko-','markersize',5,'markerfacecolor',.7*ones(1,3));
        else
            set(tp1,'XData',XS{5}(1:10:(10*xi),1),'YData',XS{5}(1:10:(10*xi),2))
        end
        
        if ~exist('tp6','var')
            tp1 = plot(XS{6}(1:10:(10*xi),1),XS{6}(1:10:(10*xi),2),'ko-','markersize',5,'markerfacecolor',.7*ones(1,3));
        else
            set(tp1,'XData',XS{6}(1:10:(10*xi),1),'YData',XS{6}(1:10:(10*xi),2))
        end
        
        if ~exist('tp7','var')
            tp1 = plot(XS{7}(1:10:(10*xi),1),XS{7}(1:10:(10*xi),2),'ko-','markersize',5,'markerfacecolor',.7*ones(1,3));
        else
            set(tp1,'XData',XS{7}(1:10:(10*xi),1),'YData',XS{7}(1:10:(10*xi),2))
        end
        
        frm = getframe(gcf);
        writeVideo(myVid,frm)
        fm = fm+1;
    end
    
    for fi = 1:6
        frm = getframe(gcf);
        writeVideo(myVid,frm)
        fm = fm+1;
        %         pause(1)
    end
end

close(myVid)
%%
savpath = 'C:\Users\Ni Ji\Dropbox (MIT)\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Animations\';
cd(savpath)

