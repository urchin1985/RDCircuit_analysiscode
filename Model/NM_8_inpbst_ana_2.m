% compare state durations for full and ctrl architectures
% external params
idn = 52000; XS0=[0 1.1];
xr1 = [-1 8]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0; nfi = 31;
rl = ceil(length(ilst)/2);
ng = .2;

% internal params
mbi = [];
prm = mpset.pm(end);
prm.a = [1.6 3.6];
prm.ki = [.4 1];
prm.ni = [4 5];
prm.b = [0 0];
prm.beta = [4 3.7];
prm.k = [4.25 3.75]; %prm.n(4)=2;
prm.n = [2 2];%[1.6 2];

ilst = (.55:.025:1.35);
xinc = .5;
xeds = 0:xinc:7;
clear gmset mdc
drmat1 = nan(length(ilst),2); drmat2 = drmat1;

figure(71);clf; hold all

for ii = 1:length(ilst)
    prm.i = ilst(ii);
    inp.i = ilst(ii)*ones(1,idn); %  .3*ones(1,idn) 0.1*ones(1,200)
    % simulate dynamics
    prm.ic = 1;
    XS = runnmod_nsy(XS0,prm,inp,ng);
    % segment states by fitting GMM, then quantify state durations
    gmfit = fitgmplt(XS,[],2,-1); % set fid to <=0 if no plot wanted
    if abs(diff(gmfit.mu(:,1)))>2
        clx = cluster(gmfit,XS);
        icx = (clx==1);
        dvec1 = getdurs(icx);
        icx = (clx==2);
        dvec2 = getdurs(icx);
    else
        icx = (XS(:,1)>3);
        dvec1 = getdurs(icx);
        icx = (XS(:,2)>3);
        dvec2 = getdurs(icx);
    end
    drmat1(ii,:) = [mean(dvec1) mean(dvec2)];
    
    prm.ic = 0;
    XS = runnmod_nsy(XS0,prm,inp,ng);
    % segment states by fitting GMM, then quantify state durations
    gmfit = fitgmplt(XS,[],2,-1); % set fid to <=0 if no plot wanted
    if abs(diff(gmfit.mu(:,1)))>2
        clx = cluster(gmfit,XS);
        icx = (clx==1);
        dvec1 = getdurs(icx);
        icx = (clx==2);
        dvec2 = getdurs(icx);
    else
        icx = (XS(:,1)>3);
        dvec1 = getdurs(icx);
        icx = (XS(:,2)>3);
        dvec2 = getdurs(icx);
    end
    
    drmat2(ii,:) = [mean(dvec1) mean(dvec2)];
    
    plot(drmat1(ii,1),drmat1(ii,2),'bo')
    plot(drmat2(ii,1),drmat2(ii,2),'ro')
    drawnow
end
xlim([0 300]);ylim([0 300])
xlabel('X1 hi state duration (a.u.)')
ylabel('X2 hi state duration (a.u.)')
legend('full','ctrl'); legend('boxoff')
%%
savpath = ['C:\Users\Ni Ji\Dropbox (MIT)\ImageSeg_GUI\MNI segmentation\' ...
'MNI turbotrack (dropbox)\Figures\Model\Plots\'];\
figure(71)
savname = ['statedursct'];
saveas(gcf,[savpath savname '.tif'])
saveas(gcf,[savpath savname '.fig'])
% saveas(gcf,[savpath2 savname '.eps'],'epsc')

