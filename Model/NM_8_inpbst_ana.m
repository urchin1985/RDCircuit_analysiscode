% scan for param sets that give suitable switching behavior for ctx
% external params
idn = 12000; XS0=[0 1.1];
xr1 = [-1 8]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0; nfi = 31;
rl = ceil(length(ilst)/2);
ng = .2;

% internal params
mbi = [];
prm = mpset.pm(end);
prm.ic = 1;
prm.a = [1.6 3.6];
prm.ki = [.4 1];
prm.ni = [4 5];
prm.b = [0 0];
prm.beta = [4 3.7];
prm.k = [4.25 3.75]; %prm.n(4)=2;
prm.n = [2 2];%[1.6 2];

ilst = (.45:.05:1.3)+.2*prm.ic;
xinc = .5;
xeds = 0:xinc:7;
clear gmset mdc
dbx = nan(1,length(ilst));
bmc = nan(length(ilst),2);

figure(69-prm.ic);clf; hold all
for ii = 1:length(ilst)
    prm.i = ilst(ii);
    inp.i = ilst(ii)*ones(1,idn); %  .3*ones(1,idn) 0.1*ones(1,200)
    % simulate dynamics
    XS = runnmod_nsy(XS0,prm,inp,ng);
    XS1 = XS;
    
    % segment states by fitting GMM, then calculate Davie-Bouldin index to
    % quantify degree of separation
    [gmfit,dbi] = gmclstbd(XS,-1);
    gmset(ii).mu = gmfit.mu;
    gmset(ii).sig = gmfit.Sigma;
    gmset(ii).cp = gmfit.ComponentProportion;
    gmset(ii).aic = gmfit.AIC;
    gmset(ii).bic = gmfit.BIC;
    dbx(ii) = dbi;
    
    bmc(ii,1) = calc_Bimod_Coeff(XS(:,1));
    bmc(ii,2) = calc_Bimod_Coeff(XS(:,2));
    
    % now compute marginal distributions 
    [nc1,~] = histcounts(XS(:,1),xeds);
    [nc2,~] = histcounts(XS(:,2),xeds);
    nc1 = nc1/sum(nc1); nc2 = nc2/sum(nc2);
    mdc(ii).nc1 = nc1; mdc(ii).nc2 = nc2;
    
%     subplot 311; hold all
%     plot(ii,dbi,'o','markerfacecolor','r')
    
    subplot 312; hold all
    px = [ii ii+nc1*3 ii*ones(1,length(nc1))]; py = [0 0:(length(nc1)-1) (length(nc1)-1):-1:0]*xinc;
    patch(px,py,'b')
    
    subplot 313; hold all
    px = [ii ii+nc2*3 ii*ones(1,length(nc1))]; py = [0 0:(length(nc1)-1) (length(nc1)-1):-1:0]*xinc;
    patch(px,py,'b')
    drawnow
end
%%
subplot 312; ylabel('X1 value (a.u.)')
subplot 313; xlabel('Input magnitude (a.u.)'); ylabel('X1 value (a.u.)')
xlm = get(gca,'xlim');
    subplot 311; cla; hold all
    plot(xlm,.45*ones(1,2),'k:')
    plot(bmc,'.-')
    xlim(xlm)
    ylabel('Bimodality coefficient')
    legend('X1','X2'); legend('boxoff')
    figure(70);hold all;plot(dbx)
%% 
% savpath = 'C:\Users\Ni Ji\Dropbox (MIT)\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\';
% figure(68)
% savname = ['inpresp_ana_ic' num2str(prm.ic)];
% saveas(gcf,[savpath savname '.tif'])
% saveas(gcf,[savpath savname '.fig'])
% % saveas(gcf,[savpath2 savname '.eps'],'epsc')

