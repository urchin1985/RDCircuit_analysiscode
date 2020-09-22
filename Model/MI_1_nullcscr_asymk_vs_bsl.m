% scan for param sets that give suitable switching behavior for ctx
idn = 3500; XS0=[0 1.1];
xr1 = [-1 8]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0;

prm.tau = [1 1];
prm.beta = 4.5*[1 1];
% prm.k = [-.5 .75]; %prm.n(4)=2;
prm.n = 4*[1 1];%[1.6 2];
% prm.b = [0.2 0.25];
ilst = 0:.25:5;%0:.2:3;
il = (length(ilst));
prm.i = .05;
inp.i = prm.i*ones(1,idn);
% % prm.dt = .25;
% % nf = 1.6;
% brang ~ [-2 2], krange [-1.5 1.5]


figure(139);clf; hold all
rmp = [];
for ii = 1:length(ilst)
    prm.ic = ilst(ii);
   
    [nco,uo] = nullcfun_sc(xr1,xr2,inc,prm,-1,dq);
    L1 = [nco.x;nco.ny]; L2 = [nco.nx;nco.y];
    P = InterX(L1,L2);
    ixp{1,ii} = P;
    figure(139)
    plot(ii,P(2,:),'b.','markersize',15)
end

%% plottin
fiid = 139;
figure(fiid);clf;hold all
%%
setsavpath
svpath = [dbpath '\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Plots\'];
svname = 'mod_2dpscan';
svfig(133,svname,svpath)

