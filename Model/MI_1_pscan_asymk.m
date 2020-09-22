% scan for param sets that give suitable switching behavior for ctx
idn = 3500; XS0=[0 1.1];
xr1 = [-1 8]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0;

prm.tau = [1 1];
prm.beta = 4.5*[1 1];
prm.k = [0 0];%[-.5 .75]; %prm.n(4)=2;
prm.n = 4*[1 1];%[1.6 2];
prm.b = 0.2*[1 1];
ilst = 0:.25:5;%0:.2:3;
il = (length(ilst));
prm.i = .05;
inp.i = prm.i*ones(1,idn);
% % prm.dt = .25;
% % nf = 1.6;
% brang ~ [-2 2], krange [-1.5 1.5]

[xk,yk] = meshgrid(-3:0.2:1,-.5:0.2:3.5);
rmt = nan(size(xk));
nmt = rmt;

for xi = 1:length(xk)
    % randomly sample baseline value pair and k/threshold value pair
    for yi = 1:length(yk)
        prm.k(1) = xk(yi,xi);prm.k(2) = yk(yi,xi);
        
        rmy = nan(1,il); rmn = rmy; ixp = [];
        for ii = 1:il
            prm.ic = ilst(ii);
            
            [nco,uo] = nullcfun_sc(xr1,xr2,inc,prm,-1,dq);
            L1 = [nco.x;nco.ny]; L2 = [nco.nx;nco.y];
            P = InterX(L1,L2);
            ixp{ii} = P;
            rmy(ii) = max(P(2,:));
            rmn(ii) = size(P,2);
        end
        
        rcr = (max(rmy)-rmy(1))*(max(rmy)-rmy(end));
        rpn = (max(rmn)-rmn(1))*(max(rmn)-rmn(end));
        
        % store results
        rmt(yi,xi) = rcr;
        nmt(yi,xi) = rpn;
    end
end
%%
fiid = 136;
figure(fiid);clf; hold all
rnmt = rmt.*(nmt>0);
figure(fiid);clf;hold all
surface(xk,yk,rmt,rmt) %,'facecolor','interp'
xlabel('k1');ylabel('k2')
%
setsavpath
svpath = [dbpath '\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Plots\'];
svname = 'modbif_kscan';
svfig(fiid,svname,svpath)

