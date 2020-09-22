% scan for param sets that give suitable switching behavior for ctx
idn = 1050; XS0=[0 1.1];
xr1 = [-1 8]; xr2 = [0 9]; inc = [.2 .2];
fid = 0; dq = 0; nfi = 30;
ihi = 1.8; iml = 1.1; imi = .53;
rl = ceil(length(ilst)/2);

prm = mpset.pm(end);
prm.ic = 0;
prm.a = [1.6 3.6];
prm.ki = [.4 1];
prm.ni = [4 5];
prm.b = [0 0];
prm.beta = [4 3.7];
prm.k = [4.25 3.75]; %prm.n(4)=2;
prm.n = [2 2];%[1.6 2];

ilst = (0.25:.05:1.8);
x00 = [-1.7 7.5;5 7.5;8 8;-1 3;-2 -1; 3 0; 6 0];

clear fp
for ii = 1:length(ilst)
    prm.i = ilst(ii);
    inp.i = [prm.i*ones(1,idn)];
    [nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,-1,dq);    
    
    xst = [];
    for ci = 1:length(x00)
        XS0 = x00(ci,:);
        xout = runnmod_nsy(XS0,prm,inp,0);
        xst = [xst;xout(end,:)];
    end
    
    if var(xst(:,1))>1
        [~,kc] = kmeans(xst,2);
        kst = sortrows(kc);
        fp.x(:,ii) = kst(:,1);
        fp.y(:,ii) = kst(:,2);
    else
        kc = mean(xst);
        fp.x(:,ii) = kc(1)*ones(2,1);
        fp.y(:,ii) = kc(2)*ones(2,1);
    end
    
    
end
%%
figure(61);clf;hold all
subplot 212; hold all
plot(fp.y','k.','markersize',12)

fd = abs(diff(fp.y)); fdb = fd>1.5;
fpp = regionprops(fdb,'PixelIdxList');
fpb = fpp(1).PixelIdxList([1 end]);
plot(fpb(1)*ones(1,2),fp.y(:,fpb(1)),'k:','linewidth',1)
plot(fpb(2)*ones(1,2),fp.y(:,fpb(2)),'k:','linewidth',1)
ylabel('X2 at steady state'); xlabel('Input level (a.u.)')

%%
clear fp
prm.ic = 1;
for ii = 1:length(ilst)
    prm.i = ilst(ii);
    inp.i = [prm.i*ones(1,idn)];
    [nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,-1,dq);    
    
    xst = [];
    for ci = 1:length(x00)
        XS0 = x00(ci,:);
        xout = runnmod_nsy(XS0,prm,inp,0);
        xst = [xst;xout(end,:)];
    end
    
    if var(xst(:,1))>1
        [~,kc] = kmeans(xst,2);
        kst = sortrows(kc);
        fp.x(:,ii) = kst(:,1);
        fp.y(:,ii) = kst(:,2);
    else
        kc = mean(xst);
        fp.x(:,ii) = kc(1)*ones(2,1);
        fp.y(:,ii) = kc(2)*ones(2,1);
    end
    
    
end
%%
figure(61);hold all

subplot 211; hold all
plot(fp.y','b.','markersize',12)

fd = abs(diff(fp.y)); fdb = fd>1.5;
fpp = regionprops(fdb,'PixelIdxList');
fpb = fpp(1).PixelIdxList([1 end]);
plot(fpb(1)*ones(1,2),fp.y(:,fpb(1)),'b:','linewidth',1)
plot(fpb(2)*ones(1,2),fp.y(:,fpb(2)),'b:','linewidth',1)
ylabel('X2 at steady state'); xlabel('Input level (a.u.)')
% legend('ctrl circuit','full circuit','location','southeast')
% legend('boxoff')
%%
savpath = ['C:\Users\Ni Ji\Dropbox (MIT)\ImageSeg_GUI\MNI segmentation\' ...
'MNI turbotrack (dropbox)\Figures\Model\Plots\'];
figure(61)
savname = ['NMbifscan2'];
saveas(gcf,[savpath savname '.tif'])
saveas(gcf,[savpath savname '.fig'])
% saveas(gcf,[savpath2 savname '.eps'],'epsc')
