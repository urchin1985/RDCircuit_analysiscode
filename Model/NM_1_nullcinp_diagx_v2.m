% define internal params below or elsewhere
refparams
% % prm.ic = 1;
% % prm.a = [1.6 3.6];
% % prm.ki = [.4 1];
% % prm.ni = [4 5]; % [4 5]
% % prm.b = [0 0];
prm.beta = [4 3.7]; % [4 3.7]
prm.k = [4 3.15]; %[4 3.15]; % [4.25 3.75]
% % prm.n = [2 2];%[1.6 2]; % [2 2]
prm.ic = 2; icf = 1;

inpfun_plot
illst = [.65 .75 .85 1.2]; % ~ Ilo Imxd Iswchf Ihi
siganalyzer_fun(prm,illst,icf)

% define external params
xr1 = [-1 10]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0; nfi = 30;
ihi = 1.8; iml = 1.1; imi = .53;
% inp.i = [.05*ones(1,idn) ihi*ones(1,idn) .05*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)

%% check nullcline evolution as I changes
prm.b = [-.5 .5];
prm.ic = 2; prm.tau = 5*[1 1];
ilst = (0:.2:1.8);
rl = ceil(length(ilst)/2);

figure(19-(prm.ic));clf;hold all
for ii = 1:length(ilst)
    subplot(2,rl,ii); hold all;
    prm.i = ilst(ii);
    title(num2str(prm.i))
    [nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,0,dq);
    caxis([0 .75])
    if ii>1
        plot(nco.x,pry,'g:','linewidth',1.5); 
        plot(prx,nco.y,'r:','linewidth',1.5)
    end
    if ii==1
    prx = nco.nx; pry = nco.ny;
    end
end
cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
colormap(cmap)

%% check state transition dynamics single vs double vs aia-
% based on nullcscreen, determine input levels for no gradient, full
% gradient, etc. to be closely checked before running ctx simulations
prm.b = [0 .5];
idn = 850; ip0 = 0.75; icf = 1;
fid = 0; dq = 0; nl = .25;
inp.i = [1.65:-.05:ip0 ip0*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)
% prm.beta = [3.4 3.7]; prm.b = [0 0];
% prm.k = [3.25 2.5]; %prm.n(4)=2;
% prm.n = [2 3];%[1.6 2];
prm.tau = 5*[1 1];
prm1 = prm; prm1.ic = 0; prm.ic = 2;
XS0=[0 6]; 

XS1 = runnmod_nsy_icf(XS0,prm,icf,inp,nl);
XS2 = runnmod_nsy_icf(XS0,prm1,icf,inp,nl);

prm.i = ip0; prm1.i = prm.i;

figure(18); clf; hold all
subplot(2,2,1);cla; title(num2str(prm.i))
[nco,uo] = nullcfun_nm_icf(xr1,xr2,inc,prm,icf,fid,dq);
caxis([0 .75]); hold all
% plot(XS1(:,1),XS1(:,2),'k.-','markerfacecolor','r','markersize',6) 
subplot 222; cla
plot(XS1,'.-','markersize',12)

subplot 223;cla;
[nco,uo] = nullcfun_nm_icf(xr1,xr2,inc,prm1,icf,fid,dq);
caxis([0 .75]); hold all
% plot(XS2(:,1),XS2(:,2),'k.-','markerfacecolor','r','markersize',6) 
subplot 224; cla
plot(XS2,'.-','markersize',12)

% infer Issw->max diff I-->Iorthg~>ip0 (full mod switches but not unilateral mod)
% infer Ilo~>Iorthg yet where inp5ht(I)>inppdfr(I), so left of crossing pt
%>>> summary Iorthg<Imaxdiff<Iswchfc<Ilo<Iinpx<Ihi
% gradient-evoked input should center on or slightly above Imaxdiff (tho further from Iswchf)
% the span should approx Ihi-Imaxdiff
%% now design gradient-related input accordingly
% prm.ic = 1; 
ilst = [.65 .75 .85 1.2]; % ~ Ilo Imxd Iswchf Ihi
icf = .5;
% inpfun_plot
siganalyzer_fun(prm,ilst,icf)
% conclude gradinp to be sig(.75,.6),spanning .15-1.35
% specifically, gd*rsp=.6 with a shift of .75
%% check sample ctx traj
nth = 3.5; dwd = 30; rmd = 500; icf = 1;
aem = 3.2; hp1 = .1; rsp = .35; % roaming speed
wsp = rsp; inp.fc = prm.fc;
rmg = 1; bx = 50; rmx = 20;
gd = 2.5; % max sensory input per unit movement along gradient direction (x axis)
nf = .5; 
N = 800;
prm.fc = 1; 
prm.tau = 1*[1 1];
prm.ic = 2; gtp = 1;

XS0=[0 1.1]; % initial condition
XS = XS0;
loc0 = [0 0];
loc = loc0;
clear ha RD inc.i
ha(1) = 2*(rand-.5)*pi; RD(1) = 1; inp.i = 0;
han = normrnd(0,aem,[1 N]); han = smooth(han,81);

Xt=XS;
for ti=2:N
    update_traj
end
%
figure(29);clf;hold all
subplot(5,1,1:3); hold all
plot(loc(:,1),loc(:,2),'.-')
plot(loc(1,1),loc(1,2),'ro')
dwi = RD==0;
plot(loc(dwi,1),loc(dwi,2),'r^')
xln = get(gca,'xlim');
% xlim([-50 50])
xlim([xln(1) max(xln(2),100)])
ylim(50*[-1 1])
subplot 514; hold all
plot(XS(:,1));plot(XS(:,2))
subplot 515; hold all
yyaxis left;plot(inp.i)
yyaxis right; plot(RD)

